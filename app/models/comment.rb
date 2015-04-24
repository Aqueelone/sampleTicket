class Comment
  def initialize
    after_create :notify_comment_added
  end
  
  private
def notify_comment_added
  Comment.connection.execute "NOTIFY comments, 'data'"
end

class << self
  def on_change
    Comment.connection.execute "LISTEN comments"
    loop do
      Comment.connection.raw_connection.wait_for_notify do |event, pid, comment|
        yield comment
      end
    end
  ensure
    Comment.connection.execute "UNLISTEN comments"
  end
end

end