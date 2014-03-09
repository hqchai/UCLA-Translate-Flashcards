package flashcards;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class QuizServlet extends HttpServlet {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    /**
     * Gives back the first card. Also 
     * Called by Deck.jsp
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            GoogleDatastoreFacade facade = new GoogleDatastoreFacade();
            String deckName = URLDecoder.decode( (String) request.getParameter("deckName"), "UTF-8");
        } catch (AuthorizationException e) {
            HomePageServlet.redirectToLogin(response);
        }        
    }
    
    /**
     * Receives information about the card just displayed. Also returns next card
     * Called by Quiz.jsp
     */
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
    }
}