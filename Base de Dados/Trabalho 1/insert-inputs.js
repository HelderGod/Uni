const name = "Guilherme";
let arr = ['Albânia', 'Alemanha', 'Andorra', 'Áustria', 'Bélgica', 'Bielorrúsia', 'Bósnia e Herzegovina', 'Bulgária', 'Cazaquistão', 'Chipre', 'Croácia', 'Dinamarca', 'Eslováquia', 'Eslovênia', 'Espanha', 'Estônia', 'Finlândia', 'França', 'Grécia', 'Hungria', 'Irlanda', 'Islândia', 'Itália', 'Letônia', 'Liechtenstein', 'Lituânia', 'Luxemburgo', 'Malta', 'Moldávia', 'Mônaco', 'Montenegro', 'Noruega', 'Países Baixos', 'Polónia', 'Portugal', 'Checoslováquia', 'Macedónia do Norte', 'Inglaterra', 'Escócia', 'Irlanda do Norte', 'País de Gales', 'Roménia', 'Rússia', 'San Marino', 'Sérvia', 'Suécia', 'Suíça', 'Turquia', 'Ucrânia', 'Vaticano'];
for (let i in arr) {
    console.log("INSERT INTO gostade VALUES('"+name+"','"+arr[i]+"');");
}
