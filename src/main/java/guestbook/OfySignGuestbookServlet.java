// https://integrated-oath-255605.appspot.com

package guestbook;


import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import static com.googlecode.objectify.ObjectifyService.ofy;

 

public class OfySignGuestbookServlet extends HttpServlet {
	
	static {
        ObjectifyService.register(Greeting.class);
    } 
	

    public void doPost(HttpServletRequest req, HttpServletResponse resp)

                throws IOException {

        UserService userService = UserServiceFactory.getUserService();

        User user = userService.getCurrentUser();

 

        // We have one entity group per Guestbook with all Greetings residing

        // in the same entity group as the Guestbook to which they belong.

        // This lets us run a transactional ancestor query to retrieve all

        // Greetings for a given Guestbook.  However, the write rate to each

        // Guestbook should be limited to ~1/second.

        String guestbookName = req.getParameter("guestbookName");

        String content = req.getParameter("content");

        Greeting greet = new Greeting(user, content, guestbookName);

        ofy().save().entity(greet).now();   // synchronous
        resp.sendRedirect("/ofyguestbook.jsp?guestbookName=" + guestbookName);

    }
    

}