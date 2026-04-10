<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- Configuración de salida -->
  <xsl:output method="html" indent="yes"/>
  
  <!-- Template principal -->
  <xsl:template match="/">
    
    <html>
      <head>
        <title>Pastelería</title>
        <style>
          body { font-family: Arial; background-color: #fdf6f0; }
          h1 { color: #d35400; }
          table { border-collapse: collapse; width: 80%; }
          th { background-color: #f4a261; }
          th, td { padding: 10px; text-align: center; }
          .alto { color: green; font-weight: bold; }
          .medio { color: orange; }
          .bajo { color: red; }
        </style>
      </head>
      
      <body>
        
        <h1>Catálogo de Productos</h1>
        
        <!-- FUNCIONES XPath -->
        <p>Total de productos:
          <xsl:value-of select="count(pasteleria/producto)"/>
        </p>
        
        <p>Stock total disponible:
          <xsl:value-of select="sum(pasteleria/producto/stock)"/>
        </p>
        
        <table border="1">
          <tr>
            <th>Nombre</th>
            <th>Categoría</th>
            <th>Precio</th>
            <th>Stock</th>
            <th>Valoración</th>
          </tr>
          
          <!-- APPLY-TEMPLATES + SORT -->
          <xsl:apply-templates select="pasteleria/producto">
            <xsl:sort select="precio" data-type="number" order="ascending"/>
          </xsl:apply-templates>
          
        </table>
        
      </body>
    </html>
    
  </xsl:template>
  
  <!-- Template para cada producto -->
  <xsl:template match="producto">
    
    <!-- IF: solo productos con stock -->
    <xsl:if test="stock &gt; 0">
      
      <tr>
        
        <!-- FOR-EACH: recorrer los campos principales -->
        <xsl:for-each select="nombre | categoria | precio | stock">
          
          <td>
            <xsl:value-of select="."/>
            <!-- Añadir símbolo € solo en precio -->
            <xsl:if test="name() = 'precio'">
              <xsl:text> €</xsl:text>
            </xsl:if>
          </td>
          
        </xsl:for-each>
        
        <!-- Valoración con estilos -->
        <td>
          <xsl:element name="span">
            
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="valoracion &gt;= 4.5">alto</xsl:when>
                <xsl:when test="valoracion &gt;= 4">medio</xsl:when>
                <xsl:otherwise>bajo</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            
            <xsl:value-of select="valoracion"/>
            
          </xsl:element>
        </td>
        
      </tr>
      
    </xsl:if>
    
  </xsl:template>
  
</xsl:stylesheet>
