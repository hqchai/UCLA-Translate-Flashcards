package flashcards;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteDeckServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) {
        try {
            String deckName = (String) request.getParameter("deckName");
            GoogleDatastoreFacade datastore = new GoogleDatastoreFacade();
            datastore.deleteDeck(deckName);
            PrintWriter out = response.getWriter();
            out.println("Successfully removed deck <em>" + deckName + "</em>. Go to <em>/viewDecks</em> to view your decks.");
        } catch (AuthorizationException | IOException e) {
            //TODO: Redirect to login
        }
    }
}