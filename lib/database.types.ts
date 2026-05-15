export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.5"
  }
  public: {
    Tables: {
      calificacion_detalle_legacy: {
        Row: {
          calificacion_id: string
          id: string
          indicador_id: number
          observacion: string | null
          puntaje: number | null
          updated_at: string | null
        }
        Insert: {
          calificacion_id: string
          id?: string
          indicador_id: number
          observacion?: string | null
          puntaje?: number | null
          updated_at?: string | null
        }
        Update: {
          calificacion_id?: string
          id?: string
          indicador_id?: number
          observacion?: string | null
          puntaje?: number | null
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "calificacion_detalle_calificacion_id_fkey"
            columns: ["calificacion_id"]
            isOneToOne: false
            referencedRelation: "calificaciones_legacy"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "calificacion_detalle_indicador_id_fkey"
            columns: ["indicador_id"]
            isOneToOne: false
            referencedRelation: "indicadores"
            referencedColumns: ["id"]
          },
        ]
      }
      calificaciones_legacy: {
        Row: {
          created_at: string | null
          es_prueba: boolean | null
          estado: string | null
          fecha_fin: string | null
          fecha_inicio: string | null
          id: string
          observaciones_generales: string | null
          productor_id: string
          updated_at: string | null
          usuario_id: string
        }
        Insert: {
          created_at?: string | null
          es_prueba?: boolean | null
          estado?: string | null
          fecha_fin?: string | null
          fecha_inicio?: string | null
          id?: string
          observaciones_generales?: string | null
          productor_id: string
          updated_at?: string | null
          usuario_id: string
        }
        Update: {
          created_at?: string | null
          es_prueba?: boolean | null
          estado?: string | null
          fecha_fin?: string | null
          fecha_inicio?: string | null
          id?: string
          observaciones_generales?: string | null
          productor_id?: string
          updated_at?: string | null
          usuario_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "calificaciones_productor_id_fkey"
            columns: ["productor_id"]
            isOneToOne: false
            referencedRelation: "productores"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "calificaciones_usuario_id_fkey"
            columns: ["usuario_id"]
            isOneToOne: false
            referencedRelation: "usuarios"
            referencedColumns: ["id"]
          },
        ]
      }
      dimensiones_legacy: {
        Row: {
          color: string
          id: number
          nombre: string
        }
        Insert: {
          color: string
          id: number
          nombre: string
        }
        Update: {
          color?: string
          id?: number
          nombre?: string
        }
        Relationships: []
      }
      evaluaciones: {
        Row: {
          created_at: string | null
          es_prueba: boolean | null
          estado: string
          fecha: string
          finca_id: string
          id: string
          observaciones_generales: string | null
          tecnico_id: string
          updated_at: string | null
        }
        Insert: {
          created_at?: string | null
          es_prueba?: boolean | null
          estado?: string
          fecha?: string
          finca_id: string
          id?: string
          observaciones_generales?: string | null
          tecnico_id: string
          updated_at?: string | null
        }
        Update: {
          created_at?: string | null
          es_prueba?: boolean | null
          estado?: string
          fecha?: string
          finca_id?: string
          id?: string
          observaciones_generales?: string | null
          tecnico_id?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "evaluaciones_finca_id_fkey"
            columns: ["finca_id"]
            isOneToOne: false
            referencedRelation: "productores"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "evaluaciones_tecnico_id_fkey"
            columns: ["tecnico_id"]
            isOneToOne: false
            referencedRelation: "usuarios"
            referencedColumns: ["id"]
          },
        ]
      }
      indicadores: {
        Row: {
          descripcion: string | null
          dimension: string | null
          dimension_id: number | null
          id: number
          nombre: string
          orden: number | null
          rango_max: number | null
          rango_min: number | null
          tipo_dato: string | null
        }
        Insert: {
          descripcion?: string | null
          dimension?: string | null
          dimension_id?: number | null
          id: number
          nombre: string
          orden?: number | null
          rango_max?: number | null
          rango_min?: number | null
          tipo_dato?: string | null
        }
        Update: {
          descripcion?: string | null
          dimension?: string | null
          dimension_id?: number | null
          id?: number
          nombre?: string
          orden?: number | null
          rango_max?: number | null
          rango_min?: number | null
          tipo_dato?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "indicadores_dimension_id_fkey"
            columns: ["dimension_id"]
            isOneToOne: false
            referencedRelation: "dimensiones_legacy"
            referencedColumns: ["id"]
          },
        ]
      }
      productores: {
        Row: {
          cedula: string
          created_at: string | null
          created_by: string | null
          id: string
          municipio: string | null
          nombre_completo: string
          nombre_predio: string | null
          proyecto: string | null
          ubicacion_lat: number | null
          ubicacion_lng: number | null
          updated_at: string | null
          vereda: string | null
        }
        Insert: {
          cedula: string
          created_at?: string | null
          created_by?: string | null
          id?: string
          municipio?: string | null
          nombre_completo: string
          nombre_predio?: string | null
          proyecto?: string | null
          ubicacion_lat?: number | null
          ubicacion_lng?: number | null
          updated_at?: string | null
          vereda?: string | null
        }
        Update: {
          cedula?: string
          created_at?: string | null
          created_by?: string | null
          id?: string
          municipio?: string | null
          nombre_completo?: string
          nombre_predio?: string | null
          proyecto?: string | null
          ubicacion_lat?: number | null
          ubicacion_lng?: number | null
          updated_at?: string | null
          vereda?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "productores_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "usuarios"
            referencedColumns: ["id"]
          },
        ]
      }
      respuestas_indicadores: {
        Row: {
          evaluacion_id: string
          evidencia_url: string | null
          id: string
          indicador_id: number
          observacion: string | null
          updated_at: string | null
          valor: number | null
        }
        Insert: {
          evaluacion_id: string
          evidencia_url?: string | null
          id?: string
          indicador_id: number
          observacion?: string | null
          updated_at?: string | null
          valor?: number | null
        }
        Update: {
          evaluacion_id?: string
          evidencia_url?: string | null
          id?: string
          indicador_id?: number
          observacion?: string | null
          updated_at?: string | null
          valor?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "respuestas_indicadores_evaluacion_id_fkey"
            columns: ["evaluacion_id"]
            isOneToOne: false
            referencedRelation: "evaluaciones"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "respuestas_indicadores_indicador_id_fkey"
            columns: ["indicador_id"]
            isOneToOne: false
            referencedRelation: "indicadores"
            referencedColumns: ["id"]
          },
        ]
      }
      usuarios: {
        Row: {
          activo: boolean | null
          created_at: string | null
          email: string
          id: string
          nombre: string
          rol: string | null
        }
        Insert: {
          activo?: boolean | null
          created_at?: string | null
          email: string
          id?: string
          nombre: string
          rol?: string | null
        }
        Update: {
          activo?: boolean | null
          created_at?: string | null
          email?: string
          id?: string
          nombre?: string
          rol?: string | null
        }
        Relationships: []
      }
    }
    Views: {
      vista_detallada_calificaciones: {
        Row: {
          cedula: string | null
          detalle_id: string | null
          dimension: string | null
          evidencia_url: string | null
          fecha_evaluacion: string | null
          indicador: string | null
          municipio: string | null
          observacion: string | null
          productor: string | null
          proyecto: string | null
          puntaje: number | null
          vereda: string | null
        }
        Relationships: []
      }
    }
    Functions: {
      unaccent: { Args: { "": string }; Returns: string }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {},
  },
} as const
