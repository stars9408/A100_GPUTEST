function survey_send(obj){

	flag=false; 
	
	if(obj.uname.value == ""){
		alert("이름을 입력하세요");
		obj.uname.focus();
		return;
	}
	if(obj.company.value == ""){
		alert("회사명을 입력하세요");
		obj.company.focus();
		return;
	}
	if(obj.number.value == ""){
		alert("연락처를 입력하세요");
		obj.company.focus();
		return;
	}
	if(obj.email.value == ""){
		alert("이메일을 입력하세요");
		obj.company.focus();
		return;
	}
	if(obj.agree.checked == false){
		alert("이용약관에 동의해주세요");
		obj.agree.focus();
		return;
	}
    //obj.target = "!OK"
	obj.action="dbsql.asp";
	obj.submit();

}
function gift(){
	window.location.replace('/a100/gputest/form.asp');
}

function quizstart(){
	window.location.replace('/a100/gputest/quiz.asp');
}
function studystart(){
	window.open("http://www.krinfra.co.kr/product/product_40.asp", "_blank");
}
function again(){
	window.location.replace('/a100/gputest/index.asp');
}

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

//include function
function includeHTML() {
  var z, i, elmnt, file, xhttp;
  /*loop through a collection of all HTML elements:*/
  z = document.getElementsByTagName("*");
  for (i = 0; i < z.length; i++) {
    elmnt = z[i];
    /*search for elements with a certain atrribute:*/
    file = elmnt.getAttribute("w3-include-html");
    if (file) {
      /*make an HTTP request using the attribute value as the file name:*/
      xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4) {
          if (this.status == 200) {elmnt.innerHTML = this.responseText;}
          if (this.status == 404) {elmnt.innerHTML = "Page not found.";}
          /*remove the attribute, and call this function once more:*/
          elmnt.removeAttribute("w3-include-html");
          includeHTML();
        }
      }      
      xhttp.open("GET", file, true);
      xhttp.send();
      /*exit the function:*/
      return;
    }
  }
};






updateQuiz();
includeHTML();