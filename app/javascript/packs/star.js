// class = "ratings"の子要素を取得
const stars = document.querySelector(".ratings").children;
// const stars = document.getElementsByClassName("ratings").children;
// id = "rating-value"の要素を取得
const ratingValue = document.getElementById("rating-value");
// id = "rating-value-display"の要素を取得
const ratingValueDisplay = document.getElementById("rating-value-display");

// indexという変数を定義
let index;

// reveiwの投稿ページに遷移するとstars.lengthの値（5）だけ繰り返し
for(let i=0; i<stars.length; i++){
  // 星にカーソルが乗ったときに実行する関数を定義
  stars[i].addEventListener("mouseover", function(){
    // stars.lengthの値（5）だけ繰り返し
		// 星にカーソルが乗った時、5回繰り返される
    for(let j=0; j<stars.length; j++){
      stars[j].classList.remove("fa-star");
      stars[j].classList.add("fa-star-o");
    }
    for(let j=0; j<=i; j++){
      stars[j].classList.remove("fa-star-o");
      stars[j].classList.add("fa-star");
    }
  })
  // クリックされた星の番号+1をratingValueに代入
  stars[i].addEventListener("click", function(){
    ratingValue.value = i + 1;
    ratingValueDisplay.textContent = ratingValue.value;
    // indexにクリックされた星の番号を代入
    index = i;
  })
  stars[i].addEventListener("mouseout", function(){
    for(let j=0; j<stars.length; j++){
      stars[j].classList.remove("fa-star");
      stars[j].classList.add("fa-star-o");
    }
    for(let j=0; j<=index; j++){
      stars[j].classList.remove("fa-star-o");
      stars[j].classList.add("fa-star");
    }
  })
}