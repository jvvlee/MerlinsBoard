 MerlinsBoard.Views.CourseTabs = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.collection, "change add remove", this.render);
    this.current_user = this.collection.owner;
    this.listenTo(this.current_user, "sync", this.render)
  },
   
  render: function () {
    var renderedContent = this.template({courses: this.collection, current_user: this.current_user});
    this.$el.html(renderedContent);
    return this
  },
  
	template: JST["navigation/coursetabs"],
  
	tagName: "nav",
  
	className: "nav-coursetabs",
  
	events: {
		"click .course-tab":"showcourse"
	},
  
  showcourse: function (event) {
    event.preventDefault()
    var course_id = $(event.currentTarget).data("id");
    
    Backbone.history.navigate("course/" + course_id +"/announcements", {trigger: true});
  }
})