# A100_GPUTEST
웹 퀴즈 및 설문조사 이벤트 페이지

2021-03-08 업로드

실제 페이지 주소:
http://www.krinfra.co.kr/A100/gputest/form.asp

노션 포트폴리오 주소:
https://www.notion.so/Web-Quiz-Survey-b394d498b83c48a888eb02664a881e56

https://stars9408.github.io/A100_GPUTEST/

# 요구사항:

1. 취급하는 제품에 대한 마케팅 활동을 위해 직접 아이디어를 내어 MBTI 혹은 퀴즈 형태로 사은품을 증정하는 방식을 웹으로 개발해야합니다.
2. 아래 사항들을 충족해야 합니다.
    1. 제품에 대한 퀴즈 WEB
    2. 퀴즈 풀이 후 고객 정보를 받아오는 WEB SURVEY & DB

# 활용 Skills:

1. ASP-HTML
    1. FORM, VBSCRIPT 등
2. JAVASCRIPT
3. MSSQL DB (Microsoft DB Server Management Service)

# 프로세스:

1. 첫 페이지: 퀴즈에 대한 안내 및 퀴즈시작/제품공부 연결
    1. 퀴즈에 대한 안내
        1. 회사 홈페이지 內 제품 설명 페이지 링크
        2. 관련 제품에 대한 링크
        3. 당사의 프로모션 페이지 링크
        4. 당사 진행 해당제품에 대한 웨비나 링크
        5. 상담문의 페이지
    2. 퀴즈 시작 버튼 → 퀴즈 페이지
    3. 제품 공부 버튼 → 제품 설명 페이지
2. 퀴즈 페이지
    1. 문제 & 선택지(4항) 총 7문제
    2. 마지막 → 점수에 따른 링크 버튼
        1. 60점 이상 → 설문작성
        2. 60점 미만 → 재도전
3. 설문 페이지
    1. 이름, 전화번호, 이메일 등 필수표기 사항
    2. 추가자료 요청, 추가 요청사항 등
    3. → DB에 저장
4. 테스트

## 첫 페이지:


- 위와 같이 첫 페이지의 맨 위에는 당사 제품 링크들이 나열되어 있고, 가운데에는 상품 설명과 함께, '퀴즈시작' 및 '제품공부' 사이트 링크 버튼이 있습니다.

```bash
**index.html 에는 아래 코드 한줄로, asp파일로 전달해주는 코드입니다.**

<meta http-equiv="refresh" content="0;ur=index.asp">

index.asp 또한 간단하게 작성하였습니다.

<!DOCTYPE html>
<html lang="ko">

<a href="http://www.krinfra.co.kr/product/product_40.asp" target="_blank" rel="noopener noreferrer">한국인프라 A100 GPU 소개자료에서 공부하기</a>
<a href="http://www.krinfra.co.kr/product/product_46.asp" target="_blank" rel="noopener noreferrer">한국인프라 DGX A100에 대하여 알아보기</a>
<a href="http://krinfra.co.kr/a100/" target="_blank" rel="noopener noreferrer">한국인프라 DGX A100 프로모션 알아보기</a>
<a href="https://www.youtube.com/watch?v=rmVz7ctVP5M" target="_blank" rel="noopener noreferrer">AI를 위한 NVIDIA의 슈퍼컴퓨터 DGX 소개 및 기술 제안 웨비나</a>
<br>

	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="style.css">
		<title>A100 기초지식 테스트</title>
	</head>

<body>

	<div class="grid">
		<img src="nvidia.jpg" style="width: 280px; height: 150px;" class="center" alt="nvidia">
		<h1 class="mt-5 text-center">NVIDIA A100 GPU 기초지식 테스트<br></h1>
		<div class="gifts">
			<h2 class="mt-5 text-center">상품:<br></h2>
			<img src="starbucks.jpg" align="center" alt="starbucks" width="150" height="150" style="vertical-align:middle;margin:0px 50px">
			<img src="chicken.jpg" align="center" alt="chicken" width="150" height="150" style="vertical-align:middle;margin:0px 50px">
			<h3>퀴즈를 풀어 60점 이상의 점수를 받으신 분들에 한하여 스타벅스 및 치킨세트 기프티콘을 100% 지급해드립니다.</h3>
		</div>
		<div class="start">
			<button class="btnn" onclick="quizstart();">퀴즈 시작하기</button>
			<button class="btnn" onclick="studystart();">A100 공부하기</button>
		</div>
	</div>

</body>
    <script type="text/javascript" src="main.js"></script>
</html>
```

- javascript와 button을 통해 버튼클릭 시, 페이지를 이동하여 퀴즈를 풀거나, 공부를 할 수 있도록 하였습니다.

## 퀴즈 페이지

```bash
// 문제 객체(생성자 함수)
function Question(text, choice, answer) {
   this.text = text; // 질문 텍스트
   this.choice = choice; // 선택할 답들(배열)
   this.answer = answer; // 정답 정보
} 

// 퀴즈 정보 객체
function Quiz(questions) {
   this.score = 0; // 점수
   this.questions = questions; // 문제
   this.questionIndex = 0; // 문제 번호
}

// 정답 확인 메서드
Quiz.prototype.correctAnswer = function(answer) {
   return answer == this.questions[this.questionIndex].answer;
}

var questions = [
   new Question('NVIDIA A100 GPU의 최대 메모리 용량은 얼마일까요?', ['20GB', '30GB', '80GB', '200GB'], '80GB'),
   new Question('NVIDIA A100에는 Multi-Instance GPU(MIG) 기능이 있어 GPU를 물적으로 격리되게 분할할 수 있고<br>사용자는 독립된 자신만의 GPU를 사용할 수 있습니다.<br>1개의 A100 GPU는 최대 몇개의 Instance GPU 생성이 가능 할까요?', ['2개', '3개', '5개', '7개'], '7개'),
   new Question('NVIDIA A100에서는  GPU간의 상호연결을 위해 사용되는<br>NVIDIA GPU Interconnect는 무엇인가요?', ['NVlink', 'PCIe Gen4', 'PCIe Gen3', 'PCI'], 'NVlink'),
   new Question('세계 최초로 NVIDIA A100 Tensor 코어 GPU로 구축된<br>NVIDIA의 슈퍼컴퓨터급의 AI 시스템는 무엇인가요?', ['NVIDIA DGX A100', 'NVIDIA DGX-1', 'NVIDIA DGX-2', 'NVIDIA DGX Station'], 'NVIDIA DGX A100'),
   new Question('NVIDIA A100 GPU에 TF32라는 텐서연산유닛이 새롭게 추가 되었습니다.<br>AI 트레이닝용 TF32가 이전 세대인 V100 GPU보다 몇배의 성능향상을 보여주나요?', ['1배', '2배', '3배', '6배'], '6배'),
   new Question('현재 NVIDIA에서 가장 연산성능이 가장 좋은 GPU는 무엇인가요?', ['A100', 'V100', 'P100', 'T4'], 'A100'),
   new Question('AI 스타트업을 위한 NVIDIA 인셉션을 통해 최대 몇 %까지<br>할인혜택을 받을 수 있을까요?', ['10%', '20%', '30%', '40%'], '20%')
];

// 퀴즈 객체 생성
var quiz = new Quiz(questions);

// 문제 출력 함수
function updateQuiz() {
   var question = document.getElementById('question');
   var idx = quiz.questionIndex + 1;
   var choice = document.querySelectorAll('.btn');

   // 문제 출력
   question.innerHTML = '<div class="num">' + '문제' + idx + '</div>' + '<div class="questions">' + quiz.questions[quiz.questionIndex].text + '</div>';

   // 선택 출력
   for (var i = 0; i < 4; i++) {
      choice[i].innerHTML = quiz.questions[quiz.questionIndex].choice[i];
   }

   progress();
}

function progress() {
   var progress = document.getElementById('progress');
   progress.innerHTML = + (quiz.questionIndex + 1) + '/ ' + quiz.questions.length;
}

var btn = document.querySelectorAll('.btn');

// 입력 및 정답 확인 함수
function checkAnswer(i) {
   btn[i].addEventListener('click', function() {
      var answer = btn[i].innerText;
      if (quiz.correctAnswer(answer)) {
        // alert('정답입니다!');
         quiz.score++;
      } else {
        // alert('틀렸습니다!');
      }

      if (quiz.questionIndex < quiz.questions.length - 1) {
         quiz.questionIndex++;
         updateQuiz();
      } else {
         result();
      }
   });
}

function result() {
   var quizDiv = document.getElementById('quiz');
   var per = parseInt((quiz.score * 100) / quiz.questions.length);
   var txt = '<p class="question">결과</p>' + '<p class="score">' + per + '점' + '</p>' + '<p id="score">당신의 정답 개수 : ' + quiz.score + '/' + quiz.questions.length + '</p>';

   quizDiv.innerHTML = txt;

   // 점수별 결과 텍스트
   if (per < 60) {
      txt += '<p class="result"><i class="far fa-sad-cry"></i><br>기프티콘을 위해서는 좀 더 분발하셔야 할 것 같아요.. 재도전!!</p>';
	  txt += '<button class="btnHome" onclick="again();"><i class="fas fa-redo-alt"></i>재도전</button>'
      quizDiv.innerHTML = txt;
   } else if (per >= 60 && per < 80) {
      txt += '<p class="result"><i class="far fa-smile"></i><br>무난한 점수네요. 기프티콘에 응모를 해보세요.</p>'
	  txt += '<button type="button" class="btn" onclick="gift();">기프티콘 응모하기</button><br>'
	  txt += '<button class="btnHome" onclick="again();"><i class="fas fa-redo-alt"></i>재도전</button>'
	  quizDiv.innerHTML = txt;
   } else if (per >= 80) {
      txt += '<p class="result"><i class="far fa-grin-hearts"></i><br>훌륭합니다. 기프티콘을 받을 수 있겠는데요?</p>'
	  txt += '<button type="button" class="btn" onclick="gift();">기프티콘 응모하기</button><br>'
	  txt += '<button class="btnHome" onclick="again();"><i class="fas fa-redo-alt"></i>재도전</button>'
      quizDiv.innerHTML = txt;
   }
}

for (var i = 0; i < btn.length; i++) {
	checkAnswer(i);
}
```

## 퀴즈 완료 후, 모습

- 퀴즈를 다 풀게 되면 위와 같은 화면이 출력됩니다.
    - 점수에 따라 글귀가 달라지며, 버튼또한 출력/미출력이 다릅니다.
    - 재도전을 클릭하면 다시 첫 페이지로 돌아가게 됩니다.

## DB

- Database의 모습입니다.
    - RegisterNum 은 Primary Key로써 열 속성의 'ID 사양'을 '예'로 해주고, 시드와 증가값을 1로 맞추어 주어 자동으로 1에서 증가하여 값이 증가하여 주어지도록 하였습니다.
    - RegDate 또한, 등록일이기 때문에 (getDate())을 사용하여 DB에 값이 입력될 때의 Datetime을 자동으로 넣어주게 하였습니다.

    들어간 값들의 모습

# 또 다른 습득

- **Visual Studio Code를 활용하여 Gibhub에 연동하는 방법에 대해 알아보았습니다.**
- **기존엔 EidtorPlus로만 개발작업을 하다가 Visual Studio Code를 통해 여러가지 플러그인들(ASP, HTML, Git : Clone, ftp-simple 등)을 받아서 활용하였습니다.**
- **Visual Studio를 통해 제 Github 계정과 연동하여, Commit-Pull-Push 하는 방법에 대해 알아보고 연습해보았습니다. (아직 여러가지 미숙한 점이 많다고 느껴집니다.)**

## 느낌점 및 후기:

- **기존에는 이미 존재하는 웹사이트에 기능을 추가한다거나, 게시판을 추가하는 개발요소들을 해왔었는데, 이번엔 직접 하나의 웹사이트를 처음부터 만들어 내는 과정을 맡아서 하게 되면서, 처음에 구상 및 설계하는 작업부터, 직접 비슷한 소스들을 찾아보고 활용하는 작업들, 디자이너에게 디자인을 부탁하고, 디자이너가 필요로하는 기능들이나 페이지를 생성하는 일까지 도맡아 할 수 있어서 더 많은 경험을 할 수 있었습니다.**
- **DB를 활용하는 방법도 능숙하게 할 수 있었지만, 이미 존재하는 DB에 연결해주는 파일들을 include하는 기능들을 기존에 존재하는 소스들을 통해 경로를 찾아가는 부분에서도 많이 능숙해졌다고 말할 있습니다. 이전보다 쉽게 페이지들에 존재하는 include 및 연결구문들을 찾아찾아 원하는 정보를 얻어내는 방법에 능숙하여 졌다는 것을 느낄 수 있었습니다.**
- **Github를 통해 원하는 방식의 다른 소스들을 찾아서 필요한 정보들을 가져와 활용해 보았습니다. MBTI 테스트 소스코드나 웹퀴즈의 소스코드를 참고하여 위 퀴즈 및 설문조사 페이지를 만들었습니다.**
