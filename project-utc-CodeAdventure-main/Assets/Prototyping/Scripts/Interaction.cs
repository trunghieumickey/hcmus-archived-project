using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class Interaction : MonoBehaviour
{
    public List<GameObject> startLight = new List<GameObject>();
    public List<GameObject> endLight = new List<GameObject>();
    public GameObject interactNotification;
    public float interactDistance = 1.4f;
    public float speed = 4;

    static string[] Questions = {
"Who invented C and in what year?",
"Dennis Ritchie - 1972",
"Dennis Ritchie - 1970",
"Linus Torvalds - 1980",
"Bill Gates - 1950",
"A",
"Which of the following variable names are written correctly according to the naming rules of the C programming language?",
"ngay sinh",
"17ngaysinh",
"_ngaysinh",
"-ngaysinh",
"C",
"Which of the following data types is considered a basic data type in the C programming language:",
"Double type.",
"Pointer type.",
"Matching type.",
"Array type.",
"A",
"A variable is called a global variable if:",
"It is declared all functions, except main().",
"It is declared outside all functions including main().",
"It is declared outside the main() function.",
"It is declared inside main() function.",
"B",
"A variable is called a local variable if:",
"It is declared inside functions or procedures, including main().",
"It is declared inside functions except main().",
"It is declared inside main() function.",
"It is declared outside functions including main().",
"A",
"If x is a global variable and x is not a pointer, then:",
"The memory space for x can change during program execution.",
"The memory space for x can only be changed by operations with x inside main().",
"The memory space for x will be changed by operations with x in all functions, including main().",
"The memory area for x is not changed during program execution.",
"D",
"Which of the following format strings is used to print a hexadecimal, hexadecimal, one-character, character string, long integer:",
"”%d”, ”%f”, ”%s”, ”%ld”, ”%c”.",
"”%x”, ”%o”, ”%c”, ”%s”, ”%ld”.",
"”%x”, ”%o”, ”%c”, ”%s”, ”%d”.",
"”%o”, ”%x”, ”%s”, ”%c”, ”%ld” .",
"B",
"Which of the following format strings is used to print a variable address, integer, real number with precision double, single-precision real numbers?",
"”%p”, ”%d”, ”%e”, ”%f”",
"”%e”, ”%p”, ”%o” , ”%x”.",
"”%d”, %p”, ”%ld”, ”%e”, ”%f” ",
"”%p”, ”%d”, ”%f”, ”%e”, ”%d”",
"A",
"-32768 to 37267 is the range of values ​​of which variable?",
"int",
"short int",
"long int",
"A, B, C are all wrong",
"D",
"What is the result when running the program (link: http://codepad.org/NHHmRLMm)?",
"56 .",
"100.",
"Error when executing program",
"Other result",
"A",
"The result of running the program (link: http://codepad.org/vrslq9OH)  is:",
"144 <tab> 0.",
"10 <tab> FALSE.",
"8 <tab> 1.",
"Different result",
"A",
"The result of running the program (link: http://codepad.org/92UU5Mta) is:",
"1.",
"0.",
"-1.",
"None of them are correct",
"B",
"(Link: http://codepad.org/DWass9Nb) In lines 6 and 8, if you change %f to %d, what will happen?",
"The program still runs normally with a, b input as integers, and a, b as real numbers, then the program runs error",
"Can't run",
"Program still runs normally",
"Repeats endlessly",
"A",
"(Link: http://codepad.org/DWass9Nb) Input are a = 1.25, b = 37. Output will be?",
"29.6",
"-29.6",
"29.4",
"-29.25",
"B",
"(Link: http://codepad.org/UcJyH4zE) The result of running the program in the above program and when adding the statement ”break;” the end of each case is:",
"Two - Two",
"TwoThreeXYZ - Two",
"Two - TwoThreeXYZ",
"TwoThreeXYZ - TwoThreeXYZ",
"B",
"Fill in the blanks so that the result is 3 4 5 6 (Link: http://codepad.org/WDIf5iUu)",
"6 - 3 - i<=a - d",
"7 - 3 - i<a - d",
"A, B are both wrong",
"A, B are correct",
"C",
"(Link: http://codepad.org/5yrDzpGR) Which one is right if we rewrite the code in Q3 using while?",
"1 Is right",
"2 Is right",
"1, 2 are both wrong",
"1, 2 are correct",
"D",
"(Link: http://codepad.org/5yrDzpGR) Which one is right if we rewrite the code in Q3 using do-while?",
"3 is right",
"4 is right",
"3, 4 are correct",
"3, 4 are wrong",
"C"
    };
    static string[] Answers = { "O", "A", "B", "C", "D" };

    public List<GameObject> inputButtons = new List<GameObject>();

    public GameObject questionBoard;
    public GameObject questionBoardText;
    Rigidbody2D rigidbody2d;
    private Vector2 movement;
    Animator animator;
    Vector2 lookDirection = new Vector2(1, 0);
    private bool isOnQuestion = false;

    private int currentQuestion = 0;
    private int currentPart = 0;

    private int lastButtonPressed = 0;
    void Start()
    {
        rigidbody2d = GetComponent<Rigidbody2D>();
        animator = GetComponent<Animator>();
    }
    void Update()
    {
        if (isOnQuestion)
        {
            if (Input.GetKeyDown(KeyCode.Escape))
            {
                questionBoard.SetActive(false);
                isOnQuestion = false;
            }
            else if (Answers[lastButtonPressed] == Questions[currentPart * 18 + currentQuestion * 6 + 5])
            {
                currentQuestion++;
                lastButtonPressed = 0;
                if (currentQuestion < 3) updateQuestionBoard();
                else {
                    startLight[currentPart].SetActive(false);
                    endLight[currentPart].SetActive(true);
                    questionBoard.SetActive(false);
                    isOnQuestion = false;
                }
            }
            return;
        }
        interactNotification.SetActive(false);
        for (int i = 0; i < startLight.Count; i++)
        {
            if (Vector3.Distance(transform.position, startLight[i].transform.position) < interactDistance && startLight[i].activeSelf)
            {
                interactNotification.transform.position = startLight[i].transform.position + new Vector3(0, 0.6f, -1);
                interactNotification.SetActive(true);
                if (Input.GetKeyDown(KeyCode.E))
                {
                    questionBoard.SetActive(true);
                    isOnQuestion = true;
                    currentPart = i;
                    currentQuestion = 0;
                    updateQuestionBoard();
                }
            }
        }
        float horizontal = Input.GetAxis("Horizontal");
        float vertical = Input.GetAxis("Vertical");
        movement = new Vector2(horizontal, vertical);
        if (!Mathf.Approximately(movement.x, 0.0f) || !Mathf.Approximately(movement.y, 0.0f))
        {
            lookDirection.Set(movement.x, movement.y);
            lookDirection.Normalize();
        }
        animator.SetFloat("Look X", lookDirection.x);
        animator.SetFloat("Look Y", lookDirection.y);
        animator.SetFloat("Speed", movement.magnitude);
    }
    private void FixedUpdate()
    {
        if (isOnQuestion) return;
        Vector2 position = rigidbody2d.position;
        position = position + movement * speed * Time.deltaTime;
        rigidbody2d.MovePosition(position);
    }

    public void OnButtonClicked(int buttonIndex)
    {
        lastButtonPressed = buttonIndex;
    }

    private void updateQuestionBoard()
    {
        int n = currentPart * 18 + currentQuestion * 6;
        questionBoardText.GetComponent<TMPro.TextMeshProUGUI>().text = Questions[n];
        for (int i = 0; i < 4; i++)
        {
            inputButtons[i].GetComponentInChildren<TMPro.TextMeshProUGUI>().text = Answers[i+1]+ ". " + Questions[n + 1 + i];
        }
    }
}