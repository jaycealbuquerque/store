class Backoffice::CategoriesController < BackofficeController
 
  
  def index
    @categories = Category.all
  end

  def new
  	@category = Category.new
  end

  def create
  	@category = Category.new(params_category)
    if @category.save
      redirect_to backoffice_categories_path, notice: "a categoria (#{@category.description}) foi cadastrada"
    else
      render :new
    end  
  end


  def edit
  	
  end

  def update
  	
  end

  def params_category
    params.require(:category).permit(:description)
  end

end
