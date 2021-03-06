MerlinsBoard.Views.CoursesShow = Backbone.View.extend({
	initialize: function () {
		this.listenTo(this.model, "sync", this.render)
    this.user_id = MerlinsBoard.CurrentUser.id
    this.course_id = this.model.id
	},
	
	template: JST['courses/show'],
  
  className: "course-show",
	
	render: function () {
		this.$el.html(this.template({course: this.model, userID: this.user_id}));
		return this
	},
		
	events: {
		"submit .dropcourse": "dropcourse",
    "submit .enrollcourse": "enrollcourse",
    "submit .cancelcourse": "cancelcourse",
    "click .editcourse": "editcourse",
    "click .addInstructors": "addInstructors"
	},
	
//assume everything's fetched already...
//need error handling to render as well
	enrollcourse: function (event) {
		event.preventDefault();
    var enrollment = new MerlinsBoard.Models.CoursesStudent();
    enrollment.save({user_id: this.user_id, course_id: this.course_id},
    {success: function () {
        MerlinsBoard.CurrentUser.courses().add(this.model);
        this.model.enrollments().add(enrollment); //so enrollment can be deleted
        this.model.students().add(MerlinsBoard.CurrentUser); //so view can be refreshed correctly
        this.render();
      }.bind(this),
      error: function (model, resp) {
        this.$("section.errors").html("Internal Server Error - check logs for more information")
      }.bind(this)
    })
	},

	dropcourse: function (event) {
    
		event.preventDefault();
    
    var enrollment = this.model.enrollments().findWhere({user_id: this.user_id, course_id: this.course_id});
    
    enrollment.destroy({
      success: function () {
        MerlinsBoard.CurrentUser.courses().remove(this.model);
        this.model.students().remove(MerlinsBoard.CurrentUser);
        this.render();
      }.bind(this)
    });
	},

	cancelcourse: function (event) {
		event.preventDefault();
  
		this.model.destroy({
      success: function () {
        //may need to explicitly remove on that page to make changes more expedient
        Backbone.history.navigate("course/search", {trigger: true});
      },
      error: function (errors) {
        console.log(errors);
      }
    });
		
	},
  
  editcourse: function () {
    Backbone.history.navigate('#course/' + this.course_id + '/edit',{trigger: true});
  },
  
  addInstructors: function () {
    Backbone.history.navigate('#course/' + this.course_id + '/add-instructors', {trigger: true})
  }
});