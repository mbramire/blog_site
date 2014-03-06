
# Get all of our routes
get "/" do
  @posts = Post.order("created_at DESC").limit(5)
  haml :"pages/welcome"
end
 
# Get the New Post form
get "/posts/new" do
  @title = "New Post"
  @post = Post.new
  haml :"posts/new"
end

get "/posts" do
  @posts = Post.order("created_at DESC")
  haml :"posts/index"
end 
# The New Post form sends a POST request (storing data) here
# where we try to create the post it sent in its params hash.
# If successful, redirect to that post. Otherwise, render the "posts/new"
# template where the @post object will have the incomplete data that the 
# user can modify and resubmit.
post "/posts" do
  @post = Post.new(params[:post])
  if @post.save
    redirect "posts/#{@post.id}"
  else
    haml :"posts/new"
  end
end
 
# Get the individual page of the post with this ID.
get "/posts/:id" do
  @post = Post.find(params[:id])
  @title = @post.title
  @comment = Comment.new
  haml :"posts/show"
end
 
# Get the Edit Post form of the post with this ID.
get "/posts/:id/edit" do
  @post = Post.find(params[:id])
  @title = "Edit Form"
  haml :"posts/edit"
end
 
# The Edit Post form sends a PUT request (modifying data) here.
# If the post is updated successfully, redirect to it. Otherwise,
# render the edit form again with the failed @post object still in memory
# so they can retry.
put "/posts/:id" do
  @post = Post.find(params[:id])
  if @post.update_attributes(params[:post])
    redirect "/posts/#{@post.id}"
  else
    haml :"posts/edit"
  end
end
 
# Deletes the post with this ID and redirects to homepage.
delete "/posts/:id" do
  @post = Post.find(params[:id]).destroy
  redirect "/"
end

#creates comments
post "/post/:id/comments" do
  @comment = Comment.new(params[:comment])
  @post = Post.find(params[:id])
  if @comment.save
    redirect "posts/#{@post.id}"
  else
    haml :"posts/show"
  end
end
 
# Our About Me page.
get "/about" do
  @title = "About Me"
  haml :"pages/about"
end