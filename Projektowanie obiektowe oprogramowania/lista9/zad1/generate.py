import xml.etree.ElementTree as ET
from jinja2 import Environment, FileSystemLoader

tree = ET.parse('classes.xml')
root = tree.getroot()

env = Environment(loader=FileSystemLoader('.'))
template = env.get_template('class_template.j2')

for cls in root.findall('class'):
  name = cls.get('name')
  fields = [
    {
      'name': field.get('name'),
      'type': field.get('type')
    }
    for field in cls.findall('field')
  ]
  rendered = template.render(class_name=name, fields=fields)

  filename = f'{name}.py'
  with open(filename, 'w', encoding='utf-8') as f:
    f.write(rendered)

  print(f'Generated {filename}')
