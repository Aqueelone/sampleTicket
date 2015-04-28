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