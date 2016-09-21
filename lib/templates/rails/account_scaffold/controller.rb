<% empty = "  " * class_path.size;class_path.each_with_index do |module_name, i|%><%= "  " * i%>module <%=module_name.camelize%>
<% end %>
<%= empty %>class <%=singular_name.camelize%>Controller < Account::AccountController
<%= empty %>  load_and_authorize_resource

<%= empty %>  def index
<%= empty %>    @<%=singular_name.pluralize %> = @<%=singular_name.pluralize %>.paginate(:page => params[:page])
<%= empty %>  end

<%= empty %>  def show
<%= empty %>  end

<%= empty %>  def new
<%= empty %>  end

<%= empty %>  def edit
<%= empty %>  end

<%= empty %>  def create
<%= empty %>    if @<%=singular_name%>.save
<%= empty %>      flash[:notice] = '创建成功'
<%= empty %>      redirect_to ({action: :show}.merge(id: @<%=singular_name%>.id))
<%= empty %>    else
<%= empty %>      render :new
<%= empty %>    end
<%= empty %>  end

<%= empty %>  def update
<%= empty %>    if @<%=singular_name%>.update(<%=singular_name%>_params)
<%= empty %>      flash[:notice] = '成功更新'
<%= empty %>      redirect_to ({action: :show}.merge(id: @<%=singular_name%>.id))
<%= empty %>    else
<%= empty %>      render :edit
<%= empty %>    end
<%= empty %>  end

<%= empty %>  def destroy
<%= empty %>    if @<%=singular_name%>.destroy
<%= empty %>      flash[:notice] = '成功删除'
<%= empty %>      redirect_to action: :index
<%= empty %>    else
<%= empty %>      flash[:error] = '删除失败'
<%= empty %>      redirect_to action: :index
<%= empty %>    end
<%= empty %>  end

<%= empty %>  private
<%= empty %>    def <%=singular_name%>_params
<%= empty %>      params.require(:<%=singular_name%>).permit(<%=attributes.map{|a| ":#{a.name}"}.join(', ')%>)
<%= empty %>    end
<%= empty %>end
<% class_path.each_with_index do |module_name, i|%><%= "  " * (class_path.count - i - 1)%>end
<% end %>