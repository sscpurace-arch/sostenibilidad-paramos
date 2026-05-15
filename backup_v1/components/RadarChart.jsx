'use client';

import { memo, useMemo } from 'react';
import dynamic from 'next/dynamic';

const Chart = dynamic(() => import('react-apexcharts'), { ssr: false });

const BASE_OPTIONS = {
  chart: {
    type: 'radar',
    toolbar: { show: false },
    animations: { 
      enabled: true,
      easing: 'easeinout',
      speed: 800,
      animateGradually: {
        enabled: true,
        delay: 150
      },
      dynamicAnimation: {
        enabled: true,
        speed: 350
      }
    },
    dropShadow: { enabled: false },
    fontFamily: 'Outfit, system-ui, sans-serif',
  },
  stroke: { show: true, width: 2 },
  fill: { opacity: 0.15 },
  yaxis: {
    show: true,
    min: 0,
    max: 5,
    tickAmount: 5,
    labels: {
      style: { fontSize: '8px', colors: ['#cbd5e1'] },
      formatter: (val) => Math.round(val).toString(),
    },
  },
  legend: { show: false },
  plotOptions: {
    radar: {
      polygons: {
        strokeColors: '#e2e8f0',
        connectorColors: '#e2e8f0',
        fill: { colors: ['#f8fafc', '#ffffff'] },
      },
    },
  },
};

const LABEL_COLOR = '#94a3b8';
const DEFAULT_COLOR = '#42A5F5';



function RadarChartComponent({
  labels,
  datasets,
  colors,
  height = 350,
  dimensiones,
  indicadores,
}) {
  const series = useMemo(
    () =>
      (datasets ?? []).map((ds) => ({
        name: ds.name ?? 'Serie',
        data: ds.data ?? [],
      })),
    [datasets]
  );

  const shortLabels = useMemo(
    () => (labels ?? []).map((_, i) => String(i + 1)),
    [labels]
  );

  const axisLabelColors = useMemo(
    () => Array(shortLabels.length).fill(LABEL_COLOR),
    [shortLabels.length]
  );

  const options = useMemo(
    () => ({
      chart: {
        ...BASE_OPTIONS.chart,
      },
      colors: colors ?? [DEFAULT_COLOR],
      markers: {
        size: 3,
        strokeColors: '#fff',
        strokeWidth: 1,
        shape: 'circle',
        hover: { size: 5, sizeOffset: 0 },
      },
      legend: {
        show: series.length > 1,
        position: 'bottom',
        horizontalAlign: 'center',
        fontFamily: 'Outfit, sans-serif',
        fontSize: '11px',
        labels: { colors: '#64748b' },
        markers: { radius: 12, offsetX: -4 },
        itemMargin: { horizontal: 10, vertical: 5 }
      },
      dataLabels: {
        enabled: true,
        style: {
          fontSize: '9px',
          fontFamily: 'Outfit, system-ui, sans-serif',
          fontWeight: 'bold',
          colors: colors ?? [DEFAULT_COLOR],
        },
        background: {
          enabled: true,
          foreColor: '#fff',
          padding: 3,
          borderRadius: 3,
          borderWidth: 0,
          opacity: 0.85,
          dropShadow: { enabled: false },
        },
        dropShadow: { enabled: false },
      },
      xaxis: {
        categories: shortLabels,
        labels: {
          show: true,
          style: {
            fontSize: '9px',
            fontFamily: 'Outfit, system-ui, sans-serif',
            fontWeight: 700,
            colors: axisLabelColors,
          },
        },
      },
      tooltip: {
        enabled: true,
        theme: 'dark',
        style: { fontSize: '12px' },
        x: {
          formatter: (val) => {
            const idx = Number(val) - 1;
            return labels?.[idx] ?? `Indicador ${val}`;
          },
        },
        y: {
          title: {
            formatter: (seriesName) => seriesName + ':',
          },
          formatter: (val) => `${val} / 5`,
        },
        marker: { show: true },
      },
    }),
    [colors, shortLabels, axisLabelColors, labels, series.length]
  );

  return (
    <div className="flex flex-col gap-3">
      {/* Wrapper externo sin animación — solo dimensiona */}
      <div style={{ width: '100%', height }}>
        {/* Wrapper animado DENTRO — no toca el SVG durante el paint inicial */}
        <div className="mi-radar-animado" style={{ width: '100%', height: '100%' }}>
          <Chart
            options={options}
            series={series}
            type="radar"
            width="100%"
            height="100%"
          />
        </div>
      </div>

      {indicadores && indicadores.length > 0 && (
        <div className="flex flex-col gap-2 px-1">
          {(dimensiones ?? []).map((dim) => {
            const indsInDim = indicadores.filter(
              (ind) => ind.dimension_id === dim.id
            );
            if (indsInDim.length === 0) return null;
            return (
              <div key={dim.id}>
                <p
                  className="text-[9px] font-black uppercase tracking-wider mb-1"
                  style={{ color: dim.color }}
                >
                  {dim.nombre}
                </p>
                <div className="flex flex-wrap gap-x-3 gap-y-0">
                  {indsInDim.map((ind) => (
                    <span key={ind.id} className="text-[10px] text-gray-500 leading-tight">
                      <span className="font-bold text-gray-700">{ind.orden}.</span>{' '}
                      {ind.nombre}
                    </span>
                  ))}
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}

const RadarChart = memo(RadarChartComponent);
RadarChart.displayName = 'RadarChart';

export default RadarChart;