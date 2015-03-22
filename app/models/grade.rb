class Grade < ActiveRecord::Base
  validates :grade, :assignment_id, :user_id, presence: true
  validates :grade, inclusion: {in: 0..100}

  belongs_to :user
  belongs_to :assignment

  has_one :course, through: :assignment, source: :course #belongs_to through doesn't exist

  #paperclip
  has_attached_file :submission,
   :content_type => { :content_type => ["application/pdf",
    "application/vnd.ms-excel",
    "application/msword",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "text/plain"] }

  #   Migration: column for if it has submission (boolean), max score (int), change "grade" to "score", 
end
