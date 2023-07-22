program Gestion_de_la_bibliothèque;
type
  nom_prenom = record
    nom, prenom: string;
  end;

type
  bibliotheque = record   //enregistrer les informations de chaque livre
    Code: Integer;
    prix: Real;
    Author: nom_prenom;
    Title, category, Editor: String;
    Year_of_edition: Integer;
  end;
Type
 users = Record         //enregistrer les informations de chaque user
  nom,prenom,username,user_category,password:String;

 end;
Type
 Fichier= File of bibliotheque;   //Fichier livres
 fichier1= File Of users;         //Fichier user
var
  f,v:fichier;
	f1:fichier1;


procedure Ajouter(var f: fichier);   //procedure ajouter les livre
var
  c: bibliotheque;
  k: char;
	ca:String;
	i,code:Integer;
	found,found1:Boolean;
begin
  Reset(f);
	found:=False;
	Repeat    //Saisir les informations du livre
    repeat
      found := False;
      writeln('Enter the code');
      readln(code);
      for i:=0 To FileSize(f)-1 do
      begin
			Seek(f,i);
			Read(f,c);
        if c.code = code Then
        begin
          found := True;
          break;
        end;
      end;
      if found then
        writeln('Code already exists. Please enter a different code.');
    until not found;
    c.code := code;  //Entrez le code du livre
    writeln('Enter the author''s name');
    readln(c.Author.nom);   //Entrez le auteur du livre
    writeln('Enter the Title');
    readln(c.Title);        //Entrez le titre du livre
    writeln('Enter the Editor');
    readln(c.Editor);      //Entrez le Éditeur du livre
    writeln('Enter the year of edition');
    readln(c.Year_of_edition);  //Entrez l'année de publication du livre
    writeln('Enter the prix');
    readln(c.prix);   //Entrez le prix du livre
		Repeat
     writeln('Enter the category in uppercase letters (MI,ST,SNV)');
		 Readln(c.category);   //Entrez le catégorie du livre
		Until (c.category= 'MI') Or (c.category='ST') or (c.category='SNV');
		Seek(f, FileSize(f));
		Write(f, c);  //Écrivez toutes les informations dans le fichier
    writeln('Is the book finished? Enter F or T');
    readln(k);
  until (k = 't') or (k = 'T');

 // write the book record to the file
  Close(f);
end;

procedure Modifier(var f: Fichier);  //procedure Modifier du livre
var
  code: Integer;
  c: bibliotheque;
begin
  writeln('Enter the code of the book to be modified:');
  readln(code);

  reset(f);
  while not EOF(f) do
  begin
    read(f, c);
    if c.Code = code then
    begin
      writeln('Enter the new author''s family name:');
      readln(c.Author.nom);
      writeln('Enter the new author''s first name:');
      readln(c.Author.prenom);
      writeln('Enter the new Title:');
      readln(c.Title);
      writeln('Enter the new Editor:');
      readln(c.Editor);
      writeln('Enter the new year_of_edition:');
      readln(c.Year_of_edition);
      writeln('Enter the new prix:');
      readln(c.prix);
      writeln('Enter the new category (Mi,St,snv):');
      readln(c.category);
			seek(f, FilePos(f) - 1);
      write(f, c);
      writeln('Book information has been updated.');
      close(f);
      exit; // exit the loop and procedure
    end;
  end;

  writeln('Book with the given code not found in the library.');
  close(f);
end;




procedure Afficher_la_liste_des_livres(var f: Fichier);   //procedure Afficher la liste des livres
var
  i: Integer;
  c: bibliotheque;
begin
  reset(f);
  for i := 0 to FileSize(f)-1 do
  begin
    seek(f, i);
    read(f, c);
    writeln('Code: ', c.Code);
    writeln('Author: ', c.Author.nom, ' ', c.Author.prenom);
    writeln('Title: ', c.Title);
    writeln('Editor: ', c.Editor);
    writeln('Day_of_edition: ', c.Year_of_edition);
    writeln('Prix: ', c.prix);
    writeln('Category: ', c.category);
  end;
  close(f);
end;




Procedure Search_Book(Var f:fichier);   //Procedure Rechercher un livre
Var
  i: Integer;
  code: Integer;
  title: String;
  author: String;
  found: Boolean;
	c:bibliotheque;
Begin
  Reset(f);
	Read(f,c);
  found := False;

  WriteLn('Search by:');
  WriteLn('1. Code');
  WriteLn('2. Title');
  WriteLn('3. Author');
  WriteLn('Enter your choice: ');
  Readln(i);

  case i of
    1: begin
      WriteLn('Enter the code of the book: ');
      Readln(code);
      while not EOF(f) do begin
			 for i := 0 to FileSize(f)-1 do
			  Begin
				  Seek(f,i);
					Read(f,c);
          if c.Code = code then begin
            found := True;
            WriteLn('Book found:');
            WriteLn('Code: ', c.Code);
            WriteLn('Author: ', c.Author.nom, ' ', c.Author.prenom);
            WriteLn('Title: ', c.Title);
            WriteLn('Editor: ', c.Editor);
            WriteLn('Date of Edition: ', c.Year_of_edition);
            WriteLn('Price: ', c.prix:0:2);
            WriteLn('Category: ', c.category);
          end;
        end;
      end;
    end;

    2: begin
      WriteLn('Enter the title of the book: ');
      Readln(title);
      while not EOF(f) do
			  begin
        for i := 0 to FileSize(f)-1 do
			    Begin
				    Seek(f,i);
					  Read(f,c);
					  if c.Title = title then
					  begin
             found := True;
             WriteLn('Book found:');
             WriteLn('Code: ', c.Code);
             WriteLn('Author: ', c.Author.nom, ' ', c.Author.prenom);
             WriteLn('Title: ', c.Title);
             WriteLn('Editor: ', c.Editor);
             WriteLn('Date of Edition: ', c.Year_of_edition);
             WriteLn('Price: ', c.prix:0:2);
             WriteLn('Category: ', c.category);
            end;
				  end;
        End;
			 end;

    3: begin

      WriteLn('Enter the author of the book: ');
      Readln(author);
      while not EOF(f) do
			 begin
         for i := 0 to FileSize(f)-1 do
				 Begin
					Seek(f,i);
					Read(f,c);
          if (c.Author.nom = author) or (c.Author.prenom = author) then
					begin
            found := True;
            WriteLn('Book found:');
            WriteLn('Code: ', c.Code);
            WriteLn('Author: ', c.Author.nom, ' ', c.Author.prenom);
            WriteLn('Title: ', c.Title);
            WriteLn('Editor: ', c.Editor);
            WriteLn('Date of Edition: ', c.Year_of_edition);
            WriteLn('Price: ', c.prix:0:2);
            WriteLn('Category: ', c.category);
          end;
        end;
      end;
     end;
End;
End;




procedure Supprimer(var v,f: Fichier; code: Integer);  //Procedure retirer les livres
var
  i,k: Integer;
  found: Boolean;
  c: bibliotheque;
begin
  reset(f);
	Assign(V,'C:\Users\User\Downloads\Video\remplasage.dat');
	ReWrite(v);
  found := False;
  for i := 0 to FileSize(f) - 1 do
  begin
	  Seek(f, i);
    Read(f, c);
		Seek(v,i);
		Write(v,c);
    if c.code = code then
    begin
      found := True;
      k := i;
    end;
  end;
  if found Then
  begin
    ReWrite(f);
    for i := 0 to k - 1 do
    begin
      Seek(v, i);
      Read(v, c);
      Seek(f, i);
      Write(f, c);
    end;
    for i := k + 1 to FileSize(v) - 1 do
    begin
      Seek(v, i);
      Read(v, c);
      Seek(f, i - 1);
      Write(f, c);
    end;
  end;
	if not found then
	Begin
  writeln('Book with code ', code, ' not found');
	end;
	close(v);
  close(f);
end;


procedure Trier_les_livresr(var f: Fichier);  // procedure Trier les livres
var
  d, y, j, n: Integer;
  c, c1: bibliotheque;
begin
  reset(f);
  n := FileSize(f) - 1;
  for j := 0 to n do
  begin
    seek(f, j);
    read(f, c);
    d := c.Year_of_edition;
    if j < n then
    begin
      seek(f, j + 1);
      read(f, c1);
      y := c1.Year_of_edition;
      if d > y then
      begin
        seek(f, j);
        write(f, c1);
        seek(f, j + 1);
        write(f, c);
      end;
    end;
  end;
  writeln('Books sorted by year of publication.');
  close(f);
end;








Procedure ajouter_users(Var f1:fichier1);  //Procedure ajouter users
Var
  c: users;
  k: char;
	usema:String;
	i:Integer;
	found,found1:Boolean;
begin
ReWrite(f1);
	found:=False;
	Repeat
    repeat
      found := False;
      writeln('Entre the username');
      readln(usema);
      for i:=0 To FileSize(f1)-1 do
      begin
			Seek(f1,i);
			Read(f1,c);
        if c.username = usema Then
        begin
          found := True;
          break;
        end;
      end;
      if found then
        writeln('Username already exists. Please enter a different Username');
    until not found;
    c.username := usema;
    writeln('Enter the nom');
    readln(c.nom);
    writeln('Enter the prenom');
    readln(c.prenom);
		writeln('Enter the password');
    readln(c.password);
		Repeat
     writeln('Enter the user type in uppercase letters (AUTEUR,ETUDIANT)');
		 Readln(c.user_category);
		Until (c.user_category= 'AUTEUR') Or (c.user_category='ETUDIANT');
		Seek(f1, FileSize(f1));
		Write(f1,c);
    writeln('Is the users finished? Enter F or T');
    readln(k);
  until (k = 't') or (k = 'T');
  Close(f1);
end;






Procedure sign_in(Var f1: fichier1);   //Procedure Connectez-vous à un compte
Var
  found:Boolean;
  c: users;
	username:String;
	i,n,s:Integer;
	password:String;
Begin
ReWrite(f1);
ReWrite(f);
found:=False;

Repeat
WriteLn('Enter the username');
Readln(username);
WriteLn('Enter the password');
Readln(password);
For i:=0 to FileSize(f1)-1 Do
Begin
Seek(f1,i);
Read(f1,c);
If (c.username = username) and (c.password = password) Then
Begin
found:=true;
end;
break;
End;
Until found;
If c.user_category = 'ADMIN' Then
Begin
repeat
    writeln('1- Ajouter un users');
	  writeln('2- Ajouter un livre');
    writeln('3- Modifier les informations d''un livre');
    writeln('4- Supprimer un livre');
		writeln('5- Search Book');
		WriteLn('6-Afficher la liste des livres');
		WriteLn('7-Afficher Trier les livres');
    writeln('8- Quitter');
    readln(n);
    case n of
		  1: Begin
          Ajouter_users(f1);  //Connexion de procédure Ajouter_users
			   end;
      2: Ajouter(f);    //Connexion de procédure Ajouter
      3: begin
           writeln('Enter the code of the book to modify');
           Modifier(f); //Connexion de procédure Modifier
         end;
      4: begin
           writeln('Enter the code of the book to delete');
           readln(s);
           Supprimer(v,f,s); //Connexion de procédure Supprimer
         end;
			5: Begin
			    Search_Book(f); //Connexion de procédure Search_Book
			   end;
			6: Begin
			    Afficher_la_liste_des_livres(f);  //Connexion de procédure Afficher_la_liste_des_livres
			   end;
			7: Begin
					Trier_les_livresr(f); //Connexion de procédure Trier_les_livresr
			   end;
			8: Begin
			    writeln('Au revoir!');
			   end;
    else
      writeln('Choix invalide. Réessayer');
    end;
  until n = 8;
end;
If c.user_category = 'ETUDIANT' Then
Begin
repeat
		writeln('1- Search Book');
		WriteLn('2-Afficher la liste des livres');
		WriteLn('3-Afficher Trier les livres');
    writeln('4- Quitter');
    readln(n);
    case n of
			1: Begin
			    Search_Book(f); //Connexion de procédure Search_Book
			   end;
			2: Begin
			    Afficher_la_liste_des_livres(f);  //Connexion de procédure Afficher_la_liste_des_livres
			   end;
			3: Begin
					Trier_les_livresr(f);  //Connexion de procédure Trier_les_livresr
			   end;
			4: Begin
			    writeln('Au revoir!');
			   end;
    else
      writeln('Choix invalide. Réessayer');
    end;
  until n = 4;
end;
If c.user_category = 'AUTEUR'Then
Begin
repeat
    writeln('1- Ajouter un livre');
    writeln('2- Modifier les informations d''un livre');
    writeln('3- Supprimer un livre');
		writeln('4- Search Book');
		WriteLn('5-Afficher la liste des livres');
		WriteLn('6-Afficher Trier les livres');
    writeln('7- Quitter');
    readln(n);
    case n of
      1: Ajouter(f);    //Connexion de procédure Ajouter
      2: begin
           writeln('Enter the code of the book to modify');
           Modifier(f);  //Connexion de procédure Modifier
         end;
      3: begin
           writeln('Enter the code of the book to delete');
           readln(s);
           Supprimer(v,f,s);   //Connexion de procédure Supprimer
         end;
			4: Begin
			    Search_Book(f); //Connexion de procédure Search_Book
			   end;
			5: Begin
			    Afficher_la_liste_des_livres(f);  //Connexion de procédure Afficher_la_liste_des_livres
			   end;
			6: Begin
					Trier_les_livresr(f); //Connexion de procédure Trier_les_livresr
			   end;
			7: Begin
			    writeln('Au revoir!');
			   end;
    else
      writeln('Choix invalide. Réessayer');
    end;
  until n = 7;
end;
End;

begin
  assign(f, 'C:\Users\User\Downloads\Video\bibliotheque.dat');
	Assign(f1,'C:\Users\User\Downloads\Video\users.dat');
		WriteLn('Ajouter un nouveau compte');
	Ajouter_users(f1);  //Connexion de procédure Ajouter_users
	sign_in(f1);  //Connexion de procédure sign_in
	Close(f);
	Close(f1);
End.