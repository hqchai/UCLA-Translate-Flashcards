package flashcards;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.google.gson.Gson;

public class AddCardServlet extends HttpServlet {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private static final String apiKey = "AIzaSyBga9xCOSR4UgO7RElncJJJzNFWS3XvLjs";

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String deckName = request.getParameter("deckName");
            String phrase1 = request.getParameter("phrase1");
            String phrase2 = request.getParameter("phrase2");
            String sourceLanguage = request.getParameter("sourceLanguage");
            String targetLanguage = request.getParameter("targetLanguage");
            if(phrase2 == null) {
                phrase2 = translate(phrase1, sourceLanguage, targetLanguage);
            }
            //response.getOutputStream().print("Phrase1: " + phrase1 + " Phrase2: " + phrase2 + " Deck Name: " + deckName);
            Flashcard flashcard = new Flashcard(phrase1, phrase2);
            GoogleDatastoreFacade googleDatastoreFacade = new GoogleDatastoreFacade();
            Deck deck = googleDatastoreFacade.getDeck(deckName);
            if (deck == null) {
                response.sendError(500);
                return;
            }
            List<Flashcard> flashcardList = deck.cards;
            if (flashcardList == null) {
                deck.cards = new LinkedList<Flashcard>();
                flashcardList = deck.cards;
            }
            flashcardList.add(flashcard);
            //response.getOutputStream().print(deck.toString());
            googleDatastoreFacade.updateDeck(deck);
            response.sendRedirect("/editDeck?deckName=" + deckName);
        } catch (AuthorizationException e) {
            HomePageServlet.redirectToLogin(response);
        }
    }

    public String translate(String sourceText, String sourceLanguage, String targetLanguage) {
        LanguageCoder languageCoder = LanguageCoder.getInstance();
        String sourceLanguageCode = languageCoder.getCode(sourceLanguage);
        String targetLanguageCode = languageCoder.getCode(targetLanguage);

        CloseableHttpClient client = HttpClients.createDefault();
        try {
            URI uri = new URIBuilder()
                    .setScheme("https")
                    .setHost("www.googleapis.com")
                    .setPath("/language/translate/v2")
                    .setParameter("key", apiKey)
                    .setParameter("source", sourceLanguageCode)
                    .setParameter("target", targetLanguageCode)
                    .setParameter("q", sourceText)
                    .build();
            HttpGet httpGet = new HttpGet(uri);
            CloseableHttpResponse response = client.execute(httpGet);
            try {
                HttpEntity entity = response.getEntity();
                String googlejsonResponse = EntityUtils.toString(entity);
                return jsonToTranslatedWord(googlejsonResponse);
            } finally {
                response.close();
            }
        } catch (URISyntaxException | IOException e) {
            throw new RuntimeException(e);
        }
    }
    
    public String jsonToTranslatedWord(String json) {
        Gson gson = new Gson();
        GoogleTranslateResponse response = gson.fromJson(json, GoogleTranslateResponse.class);
        return response.data.translations[0].translatedText;
    }
}

class GoogleTranslateResponse {
    public Data data;
}

class Data {
    public Translation[] translations;
}

class Translation {
    public String translatedText;
}