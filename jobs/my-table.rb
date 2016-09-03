hrows = [
  { cols: [ {value: 'One'}, {value: 'Two'}, {value: 'Three'}, {value: 'Four'} ] }
]

rows = [
  { cols: [ {value: 'cell11'}, {value: rand(5)}, {value: rand(5)}, {value: rand(5)} ]},
  { cols: [ {value: 'cell21'}, {value: rand(5)}, {value: rand(5)}, {value: rand(5)} ]},
  { cols: [ {value: 'cell31'}, {value: rand(5)}, {value: rand(5)}, {value: rand(5)} ]},
  { cols: [ {value: 'cell41'}, {value: rand(5)}, {value: rand(5)}, {value: rand(5)} ]}
]

send_event('my-table', { hrows: hrows, rows: rows } )