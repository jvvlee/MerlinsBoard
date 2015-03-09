window.MerlinsBoard = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  Vent: _.extend({}, Backbone.Events),
  initialize: function() {
    alert('Page Loaded');
		MerlinsBoard.Courses = new MerlinsBoard.Collections.Courses();
		MerlinsBoard.CurrentUser = new MerlinsBoard.Models.User({id: window.currentUserID});
		new MerlinsBoard.Routers.Router({
     rootEl: $("main#content"),
     sideNav: $("nav.sidenav"),
     tabNav: $("nav.headernav")
    });
		Backbone.history.start();
  }
};
