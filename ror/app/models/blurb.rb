class Blurb < Exercise
  belongs_to :lesson, touch: true

  has_rich_text :content
end
