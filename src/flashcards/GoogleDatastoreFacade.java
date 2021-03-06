package flashcards;

import java.util.ArrayList;
import java.util.List;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class GoogleDatastoreFacade {
    private String userId; 
    
    public GoogleDatastoreFacade() throws AuthorizationException {
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        if (user == null) {
            throw new AuthorizationException("User not logged in");
        }
        userId = user.getUserId();
    }
    
    public List<String> getDeckNameList() throws AuthorizationException {
        
        List<Deck> decks = ofy().load().type(Deck.class).filter("userId", userId).list();
        List<String> deckNameList = new ArrayList<String>();
        for (Deck d : decks) {
            
            deckNameList.add(d.name);
        }
        
        return deckNameList;
    }
    
    public List<String> getProgressAmountList() throws AuthorizationException {
        
        List<Deck> decks = ofy().load().type(Deck.class).filter("userId", userId).list();
        List<String> progressAmountList = new ArrayList<String>();
        for (Deck d : decks) {
            
            progressAmountList.add(Integer.toString(d.getProgressAmount()));
        }
        
        return progressAmountList;
    }

    public Deck getDeck(String deckName) {
        
        List<Deck> decks = ofy().load().type(Deck.class).filter("userId", userId).list();
        for (Deck d : decks) {
            
            if (d.name.equals(deckName)) {
                
                return d;
            }
        }
        
        return null;
    }
    
    public void storeDeck(Deck deck) {

        deck.userId = userId;
        if (!deck.isDuplicateDeckName()) {
           
            ofy().save().entity(deck).now();
        }
        
        return;
    }
    
    public void storeDecks(List<Deck> deckList) {
        
        for (Deck deck : deckList) {
            
            deck.userId = userId;
            if (deck.isDuplicateDeckName()) {
                
                deckList.remove(deck);
            }
        }
        
        ofy().save().entities(deckList).now();
        
        return;
    }
   
    // Hack: For now, update a deck by deleting it and re-storing it
    public void updateDeck(Deck newDeck) {
                
        deleteDeck(newDeck.name);
        storeDeck(newDeck);
        return;    
    }
    
    public void deleteDeck(String deckName) {
        
        Deck deck = getDeck(deckName);
        if (deck != null) {
            
            ofy().delete().entity(deck).now();

        }
        
        return;
    }
}
