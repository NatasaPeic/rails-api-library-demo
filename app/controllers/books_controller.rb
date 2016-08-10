# because of linter
class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]
  def index
    @books = Book.all
    render json: @books
  end

  def show
    render json: Book.find(params[:id])
  end

  def create
    # when generating we don't have this
    @book = Book.new(book_params)
    if @book.save
      render json: @book
      # delete this, curl request won't work with it but book will be created
      # , status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      head :no_content
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    head :no_content
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author)
  end

  private :set_book, :book_params
end


# ~/wdi/training/Ruby/another-demo/rails-api-library-demo (practicing)$ curl --include --request GET http://localhost:3000/books
# HTTP/1.1 200 OK
# X-Frame-Options: SAMEORIGIN
# X-Xss-Protection: 1; mode=block
# X-Content-Type-Options: nosniff
# Content-Type: application/json; charset=utf-8
# Vary: Origin
# Etag: W/"6a27022140df5e5faababfe3091515fa"
# Cache-Control: max-age=0, private, must-revalidate
# X-Request-Id: 9503e184-b6fc-4acd-975d-612ec63d85e1
# X-Runtime: 0.004141
# Server: WEBrick/1.3.1 (Ruby/2.3.0/2015-12-25)
# Date: Wed, 10 Aug 2016 00:50:57 GMT
# Content-Length: 401
# Connection: Keep-Alive
#
# [{"id":1,"title":"Some title","author":"Some author","created_at":"2016-08-09T23:59:34.099Z","updated_at":"2016-08-09T23:59:34.099Z"},{"id":3,"title":"Some title","author":"Some some","created_at":"2016-08-09T23:59:46.095Z","updated_at":"2016-08-09T23:59:46.095Z"},{"id":4,"title":"Some title","author":"Another author","created_at":"2016-08-10T00:01:59.501Z","updated_at":"2016-08-10T00:01:59.501Z"}]~/wdi/training/Ruby/another-demo/rails-api-library-demo (practicing)$


# curl --include --request POST http://localhost:3000/books
#   --header "Content-Type: application/json"
#   --data '{
#     "book": {
#       "title": "Some title",
#       "author": "Some some"
#     }
#   }'


# ~/wdi/training/Ruby/another-demo/rails-api-library-demo (practicing)$ curl --include --request PATCH http://localhost:3000/books/6 --header "Content-Type: application/json" --data '{"book": {"title": "Some title","author": "Some SOME some"}}'
# HTTP/1.1 204 No Content
# X-Frame-Options: SAMEORIGIN
# X-Xss-Protection: 1; mode=block
# X-Content-Type-Options: nosniff
# Vary: Origin
# Cache-Control: no-cache
# X-Request-Id: 06ec1b53-309d-4a72-a6f7-8dc99306742c
# X-Runtime: 0.004986
# Server: WEBrick/1.3.1 (Ruby/2.3.0/2015-12-25)
# Date: Wed, 10 Aug 2016 01:30:38 GMT
# Connection: Keep-Alive
#
# ~/wdi/training/Ruby/another-demo/rails-api-library-demo (practicing)$




# ~/wdi/training/Ruby/another-demo/rails-api-library-demo (practicing)$ curl --include --request DELETE http://localhost:3000/books/6
# HTTP/1.1 204 No Content
# X-Frame-Options: SAMEORIGIN
# X-Xss-Protection: 1; mode=block
# X-Content-Type-Options: nosniff
# Vary: Origin
# Cache-Control: no-cache
# X-Request-Id: 6659c78b-2990-40d7-a910-3e6901eb86eb
# X-Runtime: 0.005568
# Server: WEBrick/1.3.1 (Ruby/2.3.0/2015-12-25)
# Date: Wed, 10 Aug 2016 01:32:31 GMT
# Connection: Keep-Alive
#
# ~/wdi/training/Ruby/another-demo/rails-api-library-demo (practicing)$
