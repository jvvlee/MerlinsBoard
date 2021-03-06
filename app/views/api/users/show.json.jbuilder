json.(@user, :id, :fname, :lname, :email)

json.avatar_picture @user.avatar.url(:medium)
json.avatar_picture_small @user.avatar.url(:thumb)

json.courses @user.courses do |course|
 	json.id course.id
 	json.name course.name
end
	
json.taughtcourses @user.taughtcourses do |taughtcourse|
 	json.id taughtcourse.id
 	json.name taughtcourse.name
end

json.announcements @user.announcements.includes(:author,:course) do |announcement|
  json.id announcement.id
  json.title announcement.title
  json.body announcement.body
  json.posted_at announcement.created_at.to_time.to_s
  json.course_name announcement.course.name
  json.author_name announcement.author.fname
end