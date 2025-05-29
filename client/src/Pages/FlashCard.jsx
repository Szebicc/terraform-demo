import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";

export default function FlashCard() {
    const [flashcard, setFlashCard] = useState(null)

    const { id } = useParams()
    useEffect(() => {
        async function fetchCards() {
          const response = await fetch(`/api/flashcard/${id}`);
          const flashcard = await response.json();
          setFlashCard(flashcard);
        }
        fetchCards();
      }, []);

      return flashcard && <div>
        <h1>{flashcard.question}</h1>
        <h2>{flashcard.answer}</h2>
      </div>
}