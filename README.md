# Flutter Authentication Project (TDD + Clean Architecture)

This Flutter project demonstrates **Test-Driven Development (TDD)** and **Clean Architecture** principles in action.  
Currently, it implements **user creation** and **fetching users** with proper error handling.

---

## Features

- **Create User** (`createUser`)
    - Sends API request to create a new user
    - Handles success and failure responses
    - Returns `Either<Failure, void>` for clean error handling

- **Get Users** (`getUsers`)
    - Fetches a list of users from the API
    - Handles errors with `ApiFailure`

---

## Architecture

- **Data Layer**
    - Responsible for API calls and mapping responses
    - Includes `AuthenticationRemoteDataSource` and `AuthenticationRepositoryImplementation`

- **Domain Layer**
    - Contains entities (`User`) and repository contracts
    - Focused on business logic

- **Presentation Layer**
    - Not implemented yet (learning phase)

---

### Installation

```bash
git clone <repo-url>
cd <project-folder>
flutter pub get
flutter run
