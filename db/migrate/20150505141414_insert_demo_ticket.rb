class InsertDemoTicket < ActiveRecord::Migration
  def self.up
    @user = User.create(name: "demo", email: "demo@sample.ticket.com", password: "demo", password_confirmation: "demo", is_admin: false)
    @category = Category.where(name: "Solution").last
    @ticket_status = TicketStatus.where(name: "Open").last
    Ticket.create([{
        title: "demo ticket", 
        description: 'This is a demo ticket. \\r\\n If You press button "new ticket", You could make a new ticket. \\r\\n\\r\\n ATENTION! Sing in or sign up is requered.',
        user_id: @user.id,
        category_id: @category.id,
        ticket_status_id: @ticket_status.id
        }])
  end
  def self.down
    @user = User.where(name: "demo") 
    Ticket.where(user_id: @user.last.id).delete_all()
    @user.delete_all()
  end
end
