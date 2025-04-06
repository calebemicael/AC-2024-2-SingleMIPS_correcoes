Este tutorial irá guiá-lo através dos passos necessários para compilar e executar o projeto MIPS de Ciclo Único.

## Pré-requisitos

Certifique-se de ter os seguintes softwares instalados em seu sistema:
- [Icarus Verilog](https://steveicarus.github.io/iverilog/usage/installation.html)
- [GTKWave](http://gtkwave.sourceforge.net/)

## Passos para Compilar e Executar

### 1. Clonar o Repositório

Primeiro, clone o repositório do projeto para o seu diretório local:

```sh
git clone https://github.com/Yckson/Arquitetura.git
cd Arquitetura/Projetos/MIPS\ Ciclo\ Único
```

### 2. Compilar o Projeto

Para compilar o projeto, utilize o Makefile fornecido. Execute o comando abaixo no terminal:

```sh
make all
```

Este comando irá compilar todos os arquivos Verilog e gerar o executável `mips_sim` dentro do diretório `./GTK_WAVE`.

## Compilar no Windows

Para usuários do Windows, um script `run_windows.bat` é fornecido para facilitar a compilação e execução do projeto. Siga os passos abaixo:

Para compilar o projeto, execute o script `run_windows.bat` com o argumento `all`:

```sh
run_windows.bat all
```

Este comando irá compilar todos os arquivos Verilog e gerar o executável `mips_sim` dentro do diretório `./GTK_WAVE`.

### 3. Executar a Simulação

Para executar a simulação e visualizar os resultados no GTKWave, utilize o comando:

```sh
make run
```

Este comando irá executar a simulação e abrir o GTKWave com o arquivo de configuração `GTK_STYLE.gtkw`.

## Executar no Windows

Para executar a simulação e visualizar os resultados no GTKWave através do Windows, utilize o comando:

```sh
run_windows.bat run
```

Este comando irá executar a simulação e abrir o GTKWave com o arquivo de configuração `GTK_STYLE.gtkw`.

### 4. Limpar Arquivos Gerados

Para limpar os arquivos gerados durante a compilação e simulação, utilize o comando:

```sh
make clean
```

## Limpar no Windows

Para limpar os arquivos gerados durante a compilação e simulação no Windows, utilize o comando:

```sh
run_windows.bat clean
```

## Estrutura do Projeto

- `Makefile`: Arquivo de configuração para compilar e executar o projeto.
- `Processor_testbench.v`: Testbench para simular o processador MIPS.
- `Assembly/codigo.mem`: Código assembly para ser carregado na memória de instruções.
- `GTK_WAVE/`: Diretório onde o executável e os arquivos de configuração do GTKWave são armazenados.

## Observações

- Certifique-se de que o caminho para os arquivos no Makefile e no testbench estão corretos.
- O arquivo `codigo.mem` deve estar presente no diretório `Assembly` para ser carregado na memória de instruções durante a simulação.

Seguindo esses passos, você será capaz de compilar e executar o projeto MIPS de Ciclo Único com sucesso. Boa sorte!
