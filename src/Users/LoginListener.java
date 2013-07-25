package Users;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Application Lifecycle Listener implementation class LoginListerner
 *
 */
@WebListener
public class LoginListener implements HttpSessionListener, HttpSessionAttributeListener {
    private ServletContext context = null;
    private HttpSession session = null;
    /**
     * Default constructor. 
     */
    public LoginListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see HttpSessionAttributeListener#attributeRemoved(HttpSessionBindingEvent)
     */
    public void attributeRemoved(HttpSessionBindingEvent event) {
      //   // TODO Auto-generated method stub
      //   log("attributeRemoved('" + event.getSession().getId() + "', '" +
      // event.getName() + "', '" + event.getValue() + "')");
    }

	/**
     * @see HttpSessionAttributeListener#attributeAdded(HttpSessionBindingEvent)
     */
    public void attributeAdded(HttpSessionBindingEvent event) {
        // // TODO Auto-generated method stub
        // log("attributeAdded('" + event.getSession().getId() + "', '" +
        //   event.getName() + "', '" + event.getValue() + "', " + new Date() + ")");
    }

	/**
     * @see HttpSessionAttributeListener#attributeReplaced(HttpSessionBindingEvent)
     */
    public void attributeReplaced(HttpSessionBindingEvent event) {
      //   // TODO Auto-generated method stub
      //   log("attributeReplaced('" + event.getSession().getId() + "', '" +
      // event.getName() + "', '" + event.getValue() + "', " + new Date() + ")");
    }

    /**
     * Record the fact that this web application has been initialized.
     *
     * @param event The servlet context event
     */
    public void contextInitialized(ServletContextEvent event) {

    }

    /**
     * Record the fact that this web application has been destroyed.
     *
     * @param event The servlet context event
     */
    public void contextDestroyed(ServletContextEvent event) {

      // log("contextDestroyed()");
      this.context = null;

  }

	/**
     * @see HttpSessionListener#sessionCreated(HttpSessionEvent)
     */
    public void sessionCreated(HttpSessionEvent event) {   	
    	User currentUser = null;

        session = event.getSession();
        session.setAttribute("currentUser", currentUser);
   }

	/**
     * @see HttpSessionListener#sessionDestroyed(HttpSessionEvent)
     */
    public void sessionDestroyed(HttpSessionEvent event) {
        // TODO Auto-generated method stub
        // log("sessionDestroyed('" + event.getSession().getId() + "', " + new Date() + ")");
    }

     /**
     * Log a message to the servlet context application log.
     *
     * @param message Message to be logged
     */
//     private void log(String message) {
//
//      // if (context != null)
//      //     context.log("SessionListener: " + message);
//      // else
//      //     System.out.println("SessionListener: " + message);
//
//  }
//
//
//    /**
//     * Log a message and associated exception to the servlet context
//     * application log.
//     *
//     * @param message Message to be logged
//     * @param throwable Exception to be logged
//     */
//    private void log(String message, Throwable throwable) {
//
//      // if (context != null)
//      //     context.log("SessionListener: " + message, throwable);
//      // else {
//      //     System.out.println("SessionListener: " + message);
//      //     throwable.printStackTrace(System.out);
//      // }
//
//  }


}
