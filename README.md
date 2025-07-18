# MatchMate - Matrimonial Card Interface (iOS)

## Overview

**MatchMate** is a matrimonial iOS application designed to provide a user-friendly matchmaking experience through an easy-to-understand interface featuring match cards.  
Users can seamlessly browse through potential matches and decide whether to accept or decline profiles based on their preferences.  
All user choices and preferences are reliably stored using **Core Data**, enabling persistent data storage even offline.  
This allows users to access their interactions anytime, regardless of network connectivity.

---

## Features

- **API Integration**:  
  Fetches user profiles using [`https://randomuser.me/api/?results=10`](https://randomuser.me/api/?results=10) to populate match cards.

- **Match Cards**:  
  Displays user images, basic details, and two action buttons — *Accept* and *Decline* — for each potential match.

- **Accept/Decline Functionality**:  
  Users can take actions on each card, which are stored in the local database.

- **Local Database (Core Data)**:  
  Enables users to access stored data offline, including profiles and decisions.

- **Offline Mode**:  
  The app continues to work even during slow or no internet. Data syncs automatically when the connection is restored.

- **Design Patterns**:  
  Follows the **MVVM (Model-View-ViewModel)** architecture to separate concerns and improve maintainability.

- **Clean UI**:  
  Offers a visually appealing interface following iOS design guidelines.

- **Error Handling**:  
  Gracefully handles API errors, database issues, and network connectivity problems.

---

## Libraries & Tools Used

- **SwiftUI**: Building the user interface.
- **Combine**: Managing asynchronous operations and data flow.
- **Core Data**: Offline storage and local database management.
- **NWPathMonitor (Network framework)**: Monitoring network connectivity.

---

## Architectural Design

### MVVM (Model-View-ViewModel)

- **Model**: Represents user data (fetched from API or stored in Core Data).
- **View**: SwiftUI views rendering UI components.
- **ViewModel**: Manages business logic, API calls, and Core Data interactions.

---

## Installation

1. Clone the repository:
   ```bash
   git clone <repository_url>
