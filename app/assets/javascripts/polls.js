document.addEventListener("DOMContentLoaded", () => {
  // Function to add a new question
  document.querySelector(".add-question").addEventListener("click", (e) => {
    e.preventDefault();
    const questionsContainer = document.getElementById("questions-fields");
    const questionTemplate = document.getElementById("question-template").innerHTML;
    questionsContainer.insertAdjacentHTML("beforeend", questionTemplate);
  });

  // Event delegation to add an answer to a specific question
  document.getElementById("questions-fields").addEventListener("click", (e) => {
    if (e.target.classList.contains("add-answer")) {
      e.preventDefault();
      const answerTemplate = `
        <div class="form-group answer-field">
          <label>Answer</label>
          <input type="text" name="poll[questions_attributes][][answers_attributes][][content]" class="form-control" placeholder="Enter an answer">
        </div>`;
      e.target.insertAdjacentHTML("beforebegin", answerTemplate);
    }
  });
});
