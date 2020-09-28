# Wise Emotions Test

**Wise Emotions Test** è una semplice applicazione iOS che utilizza le ([Pokemon API](https://pokeapi.co)) per mostrare un elenco di Pokemon.
## Preview
![screencast](http://filippo-giove.com/public/image0.png)
![screencast](http://filippo-giove.com/public/image1.png)


## Funzionalità di **Wise Emotions Test**  
Un utente, aprendo l'applicazione, può visualizzare tutti i Pokemon (immagine + nome). Selezionando un Pokémon, è visualizzata una pagina di dettaglio con alcune infoprmazioni specifiche del Pokémon selezionato.
L'applicazione salva le informazione scaricate in un Db locale (si è utilizzato Core Data). Tali informazioni vengono interrogate in caso di errori o mancanza di connettività.

## Swift
**Wise Emotions Test** è implementata in **Swift 5.3**.

## Design Pattern
Si è utilizzato il pattern MVVM.

## Dependencies

[SDWebImage](https://github.com/SDWebImage/SDWebImage), utilizzando CocoaPoads. Questa libreria è stata scelta per poter visualizzare (ed effettuarne il caching) delle immagine (remote) visualizzate nell'app.

## Creator
[Filippo Giove](http://filippo-giove.com)
