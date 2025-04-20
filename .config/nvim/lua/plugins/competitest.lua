return {
  {
    'neov5/competitest.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
      compile_command = {
          c = { exec = "gcc", args = { "-std=c11", "-O2", "-Wall", "$(FNAME)", "-o", "../bin/$(FNOEXT)" } },
          cpp = { exec = "g++", args = { "-std=c++23", "-I../include", "-DLOCAL", "-O2", "-Wall", "$(FNAME)", "-o", "../bin/$(FNOEXT)" } },
          rust = { exec = "rustc", args = { "$(FNAME)" } },
          -- ocaml = { exec = "ocamlc", args = { "-o", "$(FNOEXT)", "$(FNAME)" } },
          java = { exec = "javac", args = { "$(FNAME)" } },
      },
      run_command = {
          cpp   = { exec = '../bin/$(FNOEXT)' },
          rust  = { exec = '../bin/$(FNOEXT)' },
          ocaml = { exec = 'ocaml', args = {'$(FNAME)'} }
      },
      testcases_directory = "../tc",
      received_contests_prompt_directory = false,
      received_contests_prompt_extension = false
    },
    config = function(_, opts)
      require('competitest').setup(opts)
      vim.keymap.set("n", "[r", ":CompetiTest receive testcases<cr>")
      vim.keymap.set("n", "[p", ":CompetiTest receive problem<cr>")
      vim.keymap.set("n", "[c", ":CompetiTest receive contest<cr>")
      vim.keymap.set("n", "[b", ":CompetiTest run<cr>")
    end
  }
}
