class <%=name.pluralize.camelize%>Controller < Account::AccountController
  before_action :set_<%=singular_name%>, only: [:show, :edit, :update, :destroy]

  def index
    @<%=singular_name.pluralize %> = <%=singular_name.camelize %>.all.desc("created_at").paginate(:page => params[:page])
  end

  def show

  end

  def new
    @<%=singular_name %> = <%=singular_name.camelize %>.new()
  end

  def edit

  end

  def create
    @<%=singular_name%> = <%=singular_name.camelize %>.new(<%=singular_name%>_params)
    if @<%=singular_name%>.save
      flash[:notice] = '创建成功'
      redirect_to ({action: :show}.merge(id: @<%=singular_name%>.id))
    else
      render :new
    end
  end

  def update
    if @<%=singular_name%>.update(<%=singular_name%>_params)
      flash[:notice] = '成功更新'
      redirect_to ({action: :show}.merge(id: @<%=singular_name%>.id))
    else
      render :edit
    end
  end

  def destory
    if @<%=singular_name%>.destroy
      flash[:notice] = '成功删除'
      redirect_to action: :index
    else
      flash[:error] = '删除失败'
      redirect_to action: :index
    end
  end

  private
    def <%=singular_name%>_params
      params.require(:<%=singular_name%>).permit(<%=attributes.map{|a| ":#{a.name}"}.join(', ')%>)
    end

    def set_<%=singular_name%>
      @<%=singular_name %> = <%=singular_name.camelize %>.find(params[:id])
    end
end