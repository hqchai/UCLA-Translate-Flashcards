package flashcards;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RenameDeckServlet extends HttpServlet {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String oldDeckName = (String) request.getParameter("oldDeckName");
            String newDeckName = (String) request.getParameter("newDeckName");

            GoogleDatastoreFacade datastore = new GoogleDatastoreFacade();
            if (datastore.getDeck(newDeckName) != null) {
                
                // deck with this name already exists for this user
                
                response.getWriter().print("You already have a deck named " + newDeckName + "! Press the back button in your browser and try a new name.");
                return;
            }
            Deck deck = datastore.getDeck(oldDeckName);
            if (deck != null) {
                
                datastore.deleteDeck(oldDeckName);
                deck.name = newDeckName;
                datastore.storeDeck(deck);
            }
            response.sendRedirect("/editDeck?deckName=" + URLEncoder.encode(newDeckName, "UTF-8"));
        } catch (AuthorizationException e) {
            HomePageServlet.redirectToLogin(response);
        }
    }
}