class Ad < ActiveRecord::Base


  #constante
  QTT_PER_PAGE = 6
  # callbacks
  before_save :md_to_html

  # ratyrate gem
  ratyrate_rateable 'quality'



  # associations
  belongs_to :member
  belongs_to :category, counter_cache: true
  has_many :comments

  # validates

  validates :title, :description_md,:description_short, :category,  presence: true 
  validates :picture, :finish_date, presence: true
  validates :price, numericality: { greater_than: 0}

  # scopes
	
  scope :descending_order, ->( page ) {
    order(created_at: :desc).page(page).per(QTT_PER_PAGE)
  }

  scope :search, ->(term) {
    where("lower(title) LIKE ?", "%#{term.downcase}%").page(page).per(QTT_PER_PAGE)
  }

  scope :to_the, -> (member) {Ad.where(member: member)}
  scope :by_category, -> (id, page) { where(category: id).page(page).per(QTT_PER_PAGE)}
  
  scope :random, ->(quantity) {
   Rails.env.production?
    limit(quantity).order("RAND()") #mysql 
   else 
    limit(quantity).order("RANDOM()") #sqlite
   end 
 }

#paperclip
 has_attached_file :picture, styles: {large: "800x300#", medium: "320x150#", thumb: "100x100>" }, 
 	default_url: "/images/:style/missing.png"
 validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/	
  
  # gem money_rails 
  monetize :price_cents

  def second
    self[1]
  end
   def third
    self[2]
  end

  private
    def md_to_html
      options = {
        filter_html: true,
        link_attributes: {
          rel: "nofollow",
          target: "_blank"
        }
      }
       extensions = {
        space_after_headers: true,
        autolink: true
      }
       renderer = Redcarpet::Render::HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, extensions)
       self.description = markdown.render(self.description_md)
    end
end
