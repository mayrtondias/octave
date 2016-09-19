## Copyright (C) 2016 Jesus
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} AESTRELA (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Jesus <Jesus@JESUS-PC>
## Created: 2016-09-19

function [retval] = AESTRELA (origem, destino, tamanho)
  
  #leitura dos grafo
  grafo = fopen("entrada0.txt", "r");
  #leitura das distancias
  distancias = fopen("entrada1.txt", "r");
  
  #verificando a abertura dos arquivos
  if (~grafo) || (~distancias)
    printf("erro ao abrir o arquivo\n");
  endif
  
  #recebendo os dados
  G = fscanf(grafo,"%f",[tamanho tamanho]);
  D = fscanf(distancias,"%f",[tamanho tamanho]);
  
  printf("Tabela do grafo");  
  G
  printf("Tabela das distancias"); 
  D
  
  printf("Origem: "); 
  origem
  printf("Destino: "); 
  destino
  
  
  cont = 1;
  gasto = 1;
  atual = origem;
  caminho = [origem];
  acumulado = 0;

  while(gasto ~= 0)
  
    #verificando os nos da mesma linha que o atual
    i = 1;
    cidades = [];
    while(i <= tamanho)
      cidades = [cidades,G(atual, i)];
      ++i;
    endwhile
    #print(cidades);
    cidades
    
    #verificando os nos que sao vizinhos
    cont = 1;
    cidadesAtuais = [];
    
    while(cont <= length(cidades))
      if(cidades(cont) == 1)
        cidadesAtuais = [cidadesAtuais, cont];
      endif
      cont = (cont+1);
    endwhile
    
    printf("Cidades escolhidas");
    cidadesAtuais
    
    #calculando a Heuristica 
    valores = [];
    cont = 1;
    while(cont <= length(cidadesAtuais))
      valor = D(atual,cidadesAtuais(cont))+acumulado+ D(destino,cidadesAtuais(cont));
      valores = [valores, valor];
      cont = (cont+1);
    endwhile
    
    if(length(valores) == 0)
      printf("nao ha caminho possivel");
      break;
    endif
    
    #verificando o que tem melhor custo
    if(length(valores) >= 1)
      menorValor = valores(1);
      menorIndice = cidadesAtuais(1);
    endif
    
    cont = 2;
    while(cont <= length(valores)) 
      if(valores(cont) < menorValor)
        menorValor = valores(cont);
        menorIndice = cidadesAtuais(cont);
      endif
      cont = cont+1;
    endwhile
    
    acumulado = acumulado + D(atual,menorIndice);
    atual = menorIndice;
    caminho = [caminho, atual];
    
    if(atual == destino)
      gasto = 0;
      break;
    endif
    
  endwhile
  printf("Caminho  ");
  caminho
  
  printf("fim\n");

endfunction








