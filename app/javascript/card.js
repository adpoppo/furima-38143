const pay = () => {
  Payjp.setPublicKey("pk_test_d60e85d8312e9c63939fdbc9");
  const submit = document.getElementById("button");
  submit.addEventListener('click', (e) => {
    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("purchase_customer[number]"),
      cvc: formData.get("purchase_customer[cvc]"),
      exp_month: formData.get("purchase_customer[exp_month]"),
      exp_year: `20${formData.get("purchase_customer[exp_year]")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      document.getElementById("purchase_customer_number").removeAttribute("name");
      document.getElementById("purchase_customer_cvc").removeAttribute("name");
      document.getElementById("purchase_customer_exp_month").removeAttribute("name");
      document.getElementById("purchase_customer_exp_year").removeAttribute("name");

      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener('load', pay);