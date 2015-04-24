class CommentController < ActionController::Base
  include ActionController::Live

  def index
  response.headers['Content-Type'] = 'text/event-stream'
  sse = SSE.new(response.stream)
  begin
    Comment.on_change do |comment|
      sse.write(comment)
    end
  rescue IOError
    # Client Disconnected
  ensure
    sse.close
  end
  render nothing: true
end

end
