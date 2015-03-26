class CommentsController < ApplicationController
  include ActionController::Live

  def index
    response.headers['Content-Type'] = 'text/event-stream'
    #response.header('Transfer-Encoding', 'identity');
    #response.header('Connection: keep-alive');
    sse = SSE.new(response.stream)
    begin
      # Comment.on_change do |id|
      #   comment = Comment.find(id)
      #   t = render_to_string(partial: 'comment', formats: [:html], locals: {comment: comment})
      #   sse.write(t)
      # end
        Comment.on_change do |comment|
        sse.write(comment)
        end
      puts "right"
    rescue IOError
      # Client Disconnected
      puts 'error'
    ensure
      puts 'close'
      sse.close
    end
    puts "nothing"
    render nothing: true
  end

  def new
    @comment = Comment.new
    @comments = Comment.order('created_at DESC')
  end

  def create
    if current_user
      @comment = current_user.comments.build(comment_params)
      @comment.save
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end