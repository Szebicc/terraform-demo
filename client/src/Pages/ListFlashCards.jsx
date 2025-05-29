import { useEffect, useState } from "react";
import { Link } from "react-router-dom";

export default function ListFlashCards() {
  const [flashCards, setFlashCards] = useState(null);
  const [question, setQuestion] = useState('');
  const [answear, setAnswear] = useState('');

  async function fetchCards() {
    const response = await fetch("/api/flashcards");
    const flashcards = await response.json();
    setFlashCards(flashcards);
  }
  
  useEffect(() => {
    fetchCards();
  }, []);

  async function handleSubmit(e) {
    e.preventDefault();

    const flashcard = {
        question: question,
        answer: answear,
    }

    fetch("/api/flashcards", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(flashcard),
    }).then((res) => res.json());
    fetchCards();
  }

  return (
    flashCards && (
      <div>
        <form action="" onSubmit={handleSubmit}>
          <label htmlFor="question">Question:</label>
          <input type="text" onChange={(e) => setQuestion(e.target.value)}/>
          <label htmlFor="answear">Answear:</label>
          <input type="text" onChange={(e) => setAnswear(e.target.value)}/>
          <button>Create</button>
        </form>
        {flashCards.map((card) => (
            <Link to={`/flashcard/${card._id}`}>
            <p key={card._id}>{card.question}</p>
            </Link>
        ))}
      </div>
    )
  );
}
