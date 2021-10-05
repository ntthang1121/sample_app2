class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  scope :recent_posts, ->{order created_at: :desc}
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {
      maximum: Settings.content.length_140
    }
  validates :image,
            content_type: {
              in: Settings.image.format,
              message: I18n.t("micropost_rb_validates.msg_content_type")
            },
            size: {
              less_than: Settings.image.size_1mb.megabytes,
              message: I18n.t("micropost_rb_validates.msg_size")
            }

  def display_image
    image.variant resize_to_limit: Settings.image.resize
  end
end
