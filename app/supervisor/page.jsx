'use client';
import { useEffect, useState } from 'react';
import dynamic from 'next/dynamic';
import { createClient } from '@/lib/supabase';
import { DIMENSION_COLORS } from '@/lib/db-offline';

// ApexCharts no soporta SSR
const ReactApexChart = dynamic(() => import('react-apexcharts'), { ssr: false });

function KpiCard({ value, label, color }) {
  return (
    <div className="card-glass p-4 text-center flex-1">
      <p className="text-3xl font-black" style={{ color }}>{value}</p>
      <p className="text-[10px] text-white/50 font-bold uppercase tracking-wider mt-1">{label}</p>
    </div>
  );
}

export default function SupervisorDashboard() {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [kpis, setKpis] = useState({ productores: 0, completadas: 0, pendientes: 0, promedioGlobal: 0 });
  const [promediosDimension, setPromediosDimension] = useState([]);
  const [ultimasEvals, setUltimasEvals] = useState([]);
  const supabase = createClient();

  useEffect(() => {
    // Las cifras las calcula la base (función resumen_supervisor): antes se
    // bajaban las tablas completas y el servidor cortaba en 1.000 filas, así
    // que los promedios salían de una fracción de los datos.
    async function cargar() {
      const { data, error: err } = await supabase.rpc("resumen_supervisor");
      if (err || !data) {
        setError(navigator.onLine
          ? "No se pudo cargar el resumen del proyecto. Intenta de nuevo en un momento."
          : "Este panel necesita conexión a internet.");
        setLoading(false);
        return;
      }

      setPromediosDimension((data.dimensiones || []).map(d => ({ dimension: d.dimension, promedio: Number(d.promedio) })));
      setKpis({
        productores: data.productores || 0,
        completadas: data.completadas || 0,
        pendientes: data.pendientes || 0,
        promedioGlobal: data.promedio_global != null ? Number(data.promedio_global).toFixed(1) : "0.0",
      });
      setUltimasEvals((data.ultimas || []).map(e => ({
        id: e.id,
        fecha: e.fecha,
        productor: e.productor || "Productor",
        vereda: e.vereda,
        promedio: e.promedio != null ? Number(e.promedio).toFixed(1) : "—",
      })));
      setLoading(false);
    }
    cargar();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  if (error) {
    return <div className="text-center py-16 text-amber-300 text-sm">{error}</div>;
  }

  if (loading) {
    return <div className="text-center py-16 text-white/40 text-sm">Cargando indicadores del proyecto...</div>;
  }

  const chartOptions = {
    chart: { type: 'bar', toolbar: { show: false }, background: 'transparent' },
    theme: { mode: 'dark' },
    plotOptions: { bar: { horizontal: true, borderRadius: 6, barHeight: '55%' } },
    dataLabels: { enabled: true, formatter: (v) => v.toFixed(1), style: { colors: ['#fff'] } },
    xaxis: { categories: promediosDimension.map(d => d.dimension), max: 5, labels: { style: { colors: '#ffffff80' } } },
    yaxis: { labels: { style: { colors: '#ffffffb0' } } },
    grid: { borderColor: '#ffffff15' },
    colors: promediosDimension.map(d => DIMENSION_COLORS[d.dimension] || '#03A64A'),
  };
  const chartSeries = [{ name: 'Promedio', data: promediosDimension.map(d => Number(d.promedio.toFixed(2))) }];

  return (
    <div className="flex flex-col gap-5">
      {/* KPIs */}
      <div className="flex gap-3">
        <KpiCard value={kpis.productores} label="Productores" color="#03A64A" />
        <KpiCard value={kpis.completadas} label="Evaluaciones" color="#049DD9" />
        <KpiCard value={kpis.pendientes} label="Pendientes" color="#FFC800" />
      </div>

      <div className="card-glass p-6 text-center">
        <p className="text-5xl font-black text-white">{kpis.promedioGlobal}</p>
        <p className="text-xs text-white/50 font-bold uppercase tracking-widest mt-1">Sostenibilidad promedio del proyecto (sobre 5)</p>
      </div>

      {/* Promedio por dimensión */}
      {promediosDimension.length > 0 && (
        <div className="card-glass p-5">
          <h3 className="text-xs font-black uppercase text-white/50 mb-3 tracking-widest">Balance por dimensión</h3>
          <ReactApexChart options={chartOptions} series={chartSeries} type="bar" height={180} />
        </div>
      )}

      {/* Últimas evaluaciones */}
      <div className="card-glass p-5">
        <h3 className="text-xs font-black uppercase text-white/50 mb-3 tracking-widest">Últimas evaluaciones completadas</h3>
        <div className="flex flex-col gap-2">
          {ultimasEvals.map(e => (
            <div key={e.id} className="flex items-center justify-between bg-white/5 rounded-xl px-4 py-3">
              <div className="min-w-0">
                <p className="text-sm font-bold text-white truncate">{e.productor}</p>
                <p className="text-[10px] text-white/40">{e.vereda || 'Vereda no registrada'} · {new Date(e.fecha).toLocaleDateString('es-CO')}</p>
              </div>
              <span className="shrink-0 text-lg font-black text-pnn-verde">{e.promedio}</span>
            </div>
          ))}
          {ultimasEvals.length === 0 && (
            <p className="text-center text-white/30 text-xs py-4">Aún no hay evaluaciones completadas.</p>
          )}
        </div>
      </div>
    </div>
  );
}
