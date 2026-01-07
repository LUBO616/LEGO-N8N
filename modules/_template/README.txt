MÓDULO: _template

QUÉ HACE:
- Plantilla para crear módulos nuevos de forma consistente.

ARCHIVOS:
- compose/modules/_template.yaml
- env/modules/_template.env.example
- modules/_template/README.txt

CÓMO CREAR UN MÓDULO NUEVO:
1) Copia el YAML:
   cp compose/modules/_template.yaml compose/modules/<modulo>.yaml

2) Crea assets/config del módulo:
   mkdir -p modules/<modulo>

3) Crea env example:
   cp env/modules/_template.env.example env/modules/<modulo>.env.example

4) Crea receta:
   cat > recipes/<receta>.txt <<EOF
   compose/core.yaml
   compose/modules/<modulo>.yaml
   EOF

5) Levanta:
   ./scripts/stack.sh up <receta>
