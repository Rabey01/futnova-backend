# Futnova API – Football Data Backend

Futnova API is the backend service for the Futnova football tracking app. Built with Ruby on Rails, it provides structured endpoints to fetch real-time football data including live fixtures, league standings, and detailed match information. This backend consumes third-party APIs and serves clean JSON data to the frontend.

---

## Live API

- **Render Deployment**: [https://futnova-api.onrender.com](https://futnova-api.onrender.com)

> Note: This is a public API endpoint and does not serve a web interface. It is intended to be used by the Futnova frontend application.

---

## Built With

- Ruby on Rails 8  
- HTTParty – for making API requests  
- Rack CORS – to handle cross-origin requests  
- dotenv-rails – for managing environment variables  
- SQLite (development) / PostgreSQL (production)  
- Deployed on Render  

---

## Key Endpoints

- `GET /fixtures/today` – Fetch today's football fixtures  
- `GET /fixtures/:id` – Get detailed information for a single match  
- `GET /leagues/:id/standings` – Fetch current standings for a league  
- `GET /leagues/:id/fixtures` – Get all matches for a league  

---

## Deployment

The backend is hosted on [Render](https://render.com/), with automatic deployment from the connected GitHub repository. Ensure your API keys are correctly added in the **Environment** tab of your Render dashboard.

---

## License

This project is open-source and available under the [MIT License](LICENSE).
