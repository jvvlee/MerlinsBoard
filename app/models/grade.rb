class Grade < ActiveRecord::Base
  validates :score, :assignment_id, :user_id, presence: true
  validates :score, inclusion: {in: 0..100, message: "Score must be a whole number between 0 and 100."}

  belongs_to :user
  belongs_to :assignment

  has_one :course, through: :assignment, source: :course

  #paperclip
  has_attached_file :submission,
    :url => ":class/:attachment/:id/:student_name_and_assignment_id.:extension",
    :path => ":class/:attachment/:id/:student_name_and_assignment_id.:extension"
  
  validates_attachment_content_type :submission, :content_type => [
    "application/pdf",
    "application/vnd.ms-excel",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "application/msword",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "text/plain"]
  
  def submission_from_url(url)
    self.submission = URI.parse(url)
    self.save!
  end
  
  private
  #https://github.com/thoughtbot/paperclip/wiki/interpolations
  Paperclip.interpolates :student_name_and_assignment_id do |attachment, style|
    lname = attachment.instance.user.fname
    fname = attachment.instance.user.lname
    assignment_name = attachment.instance.assignment.title
    
    return "#{lname}_#{fname}_#{assignment_name}"
  end
end
