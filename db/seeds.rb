User.create(name: "admin", email: "admin@sample.ticket.com", password: "admin", password_confirmation: "admin", is_admin: true)
User.create(name: "test", email: "test@sample.ticket.com", password: "test", password_confirmation: "test", is_admin: false)

Category.create([
                {name: "Help"},
                {name: "Solution"},
                {name: "Bug report"},
                {name: "Advice"},
                ])

TicketStatus.create([
                {name: "Open", position: 1},
                {name: "Pending P0", position: 2},
                {name: "Pending P1", position: 3},
                {name: "Aproving P0", position: 4},
                {name: "Aproving P1", position: 4},
                {name: "Closed", position: 6}
              ])
WidgetRule.create([
    {controlled_id: 1, controlled_type: "TicketStatus"},
    {controlled_id: 4, controlled_type: "Category"},
    {controlled_id: 3, controlled_type: "Category"},
    {controlled_id: 1, controlled_type: "Category"},
    {controlled_id: 2, controlled_type: "Category"},
    {controlled_id: 2, controlled_type: "TicketStatus"},
    {controlled_id: 3, controlled_type: "TicketStatus"},
    {controlled_id: 5, controlled_type: "TicketStatus"},
    {controlled_id: 4, controlled_type: "TicketStatus"},
    {controlled_id: 6, controlled_type: "TicketStatus"}
  ])

Widget.create([
{name: "[template:] Waiting for Staff Response", is_template: true, is_readonly: true, widget_rule_ids: [1, 2, 3, 4, 5, 6, 7]},
{name: "[template:] On hold", is_template: true, is_readonly: true, widget_rule_ids: [1, 3, 4, 5, 8, 9]},
{name: "Waiting for Staff Response", template_id: 1, is_readonly: true, widget_rule_ids: [1, 2, 3, 4, 5, 6, 7]},
{name: "[template:] Solved issues", is_template: true, is_readonly: true, widget_rule_ids: [1, 3, 4, 5, 10]},
{name: "Solved issues", template_id: 4, is_readonly: true, widget_rule_ids: [1, 3, 4, 5, 10]},
{name: "On hold", template_id: 2, is_readonly: true, widget_rule_ids: [1, 3, 4, 5, 8, 9]},
  ])