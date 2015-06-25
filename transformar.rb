#
#
#
module Transformar
  def transformar(cadena_u, cadena_v)
    tamano_u = cadena_u.length
    tamano_v = cadena_v.length
    return tamano_v if tamano_u == 0
    return tamano_u if tamano_v == 0
    tabla = Array.new(tamano_u + 1) { Array.new(tamano_v + 1)  }
    (0..tamano_u).each { |i| tabla[i][0] = i }
    (0..tamano_v).each { |j| tabla[0][j] = j }
    (1..tamano_u).each do |i|
      (1..tamano_v).each do |j|
        tabla[i][j] =
          if cadena_u[i - 1] == cadena_v[j - 1]
            tabla[i - 1][j - 1]
          else
            [tabla[i - 1][j] + 1,     # Eliminar
             tabla[i][j - 1] + 1,     # Insertar
             tabla[i - 1][j - 1] + 1  # Substituir
            ].min
          end
      end
    end
    tabla
  end
  
end
