class Backoffice::CategoriesController::CategoryService
	attr_accessor :category

	def self.create(parems_category)
		@category = Category.new(parems_category)

		if @category.valid?
			@category.save
			
		end
		@category
	end

end


