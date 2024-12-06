### Steps to Run the App

1. Clone the project.
2. Run the `FetchRecipeApp` target.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I prioritized modularization and componentization throughout development of the project. I think that modularization is 
extremely important in maintaining a codebase, especially as it grows large. Some benefits of modularization are quicker build
times, better testability, and better developer readability. This structure future-proofs the project as more features can be
added easily in an organized manner.

I also prioritized using the most up to date frameworks, libraries, and methodologies, including fully using SwiftUI, Swift concurrency, 
Swift Testing, and I used the MVVM + UseCase/Repo/Service architecture.

I also enabled Swift 6, existential `any`, and internal imports by default for the project and packages. This allows us to eliminate
data races at compile-time which will reduce error-prone code and ensure thread safety. The additional features provide better developer
readability and reduces unnecessary exposed dependencies.


### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent around 7-8 hours on the app. I spent it equally between implementing the views/architecture, modularization, and
figuring out how to build a cache.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I used SwiftData for caching images to get some more practice using SwiftData. While SwiftData wasn't necessarily intended 
for storing images, I utilized the `.externalStorage` attribute, which stores the image separately from the SQLite table in a 
file -- and then SwiftData references the file. 

Another solution could be building a cache that writes to a file directly writing using FileManager.

### Weakest Part of the Project: What do you think is the weakest part of your project?

I think I could've added additional UI features to provide an even better experience for the user. Some of these include
potentially adding additional filters, showing a recommendation for similar recipes, and expanding on the detail view.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

None
