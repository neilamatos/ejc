# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200214205932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cidades", force: :cascade do |t|
    t.string "nome"
    t.bigint "estado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estado_id"], name: "index_cidades_on_estado_id"
  end

  create_table "circulos", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "encontros", force: :cascade do |t|
    t.string "descricao"
    t.string "tema"
    t.string "local"
    t.string "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipe_funcoes", force: :cascade do |t|
    t.bigint "equipe_id"
    t.bigint "funcao_id"
    t.bigint "tipo_id"
    t.integer "minimo"
    t.integer "maximo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "descricao"
    t.index ["equipe_id"], name: "index_equipe_funcoes_on_equipe_id"
    t.index ["funcao_id"], name: "index_equipe_funcoes_on_funcao_id"
    t.index ["tipo_id"], name: "index_equipe_funcoes_on_tipo_id"
  end

  create_table "equipes", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipes_pessoas", force: :cascade do |t|
    t.bigint "pessoa_id"
    t.bigint "equipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipe_id"], name: "index_equipes_pessoas_on_equipe_id"
    t.index ["pessoa_id"], name: "index_equipes_pessoas_on_pessoa_id"
  end

  create_table "estados", force: :cascade do |t|
    t.string "nome"
    t.string "uf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "funcoes", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "habilidades", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "habilidades_pessoas", force: :cascade do |t|
    t.bigint "pessoa_id"
    t.bigint "habilidade_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habilidade_id"], name: "index_habilidades_pessoas_on_habilidade_id"
    t.index ["pessoa_id"], name: "index_habilidades_pessoas_on_pessoa_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "nome"
    t.string "subject_class"
    t.string "action"
    t.string "controller_namespace"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions_roles", force: :cascade do |t|
    t.bigint "permission_id"
    t.bigint "role_id"
    t.index ["permission_id"], name: "index_permissions_roles_on_permission_id"
    t.index ["role_id"], name: "index_permissions_roles_on_role_id"
  end

  create_table "pessoas", force: :cascade do |t|
    t.string "nome"
    t.date "data_nasc"
    t.bigint "encontro_id"
    t.bigint "circulo_id"
    t.bigint "tipo_id"
    t.string "endereco"
    t.string "bairro"
    t.string "telefone_1"
    t.string "telefone_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circulo_id"], name: "index_pessoas_on_circulo_id"
    t.index ["encontro_id"], name: "index_pessoas_on_encontro_id"
    t.index ["tipo_id"], name: "index_pessoas_on_tipo_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "nome"
    t.boolean "uo_dependent", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "servicos", force: :cascade do |t|
    t.bigint "pessoa_id"
    t.bigint "encontro_id"
    t.bigint "equipe_funcao_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nome_pessoa"
    t.index ["encontro_id"], name: "index_servicos_on_encontro_id"
    t.index ["equipe_funcao_id"], name: "index_servicos_on_equipe_funcao_id"
    t.index ["pessoa_id"], name: "index_servicos_on_pessoa_id"
  end

  create_table "tipo_equipista", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipos", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uos", force: :cascade do |t|
    t.string "nome"
    t.string "sigla"
    t.string "cnpj"
    t.string "endereco"
    t.string "complemento"
    t.string "bairro"
    t.bigint "estado_id"
    t.bigint "cidade_id"
    t.string "cep"
    t.string "codigo_ug"
    t.integer "codigo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cidade_id"], name: "index_uos_on_cidade_id"
    t.index ["estado_id"], name: "index_uos_on_estado_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nome"
    t.string "telefone"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.bigint "uo_id"
    t.string "username"
    t.boolean "ad_user", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["uo_id"], name: "index_users_on_uo_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "cidades", "estados"
  add_foreign_key "equipe_funcoes", "equipes"
  add_foreign_key "equipe_funcoes", "funcoes"
  add_foreign_key "equipe_funcoes", "tipos"
  add_foreign_key "equipes_pessoas", "equipes"
  add_foreign_key "equipes_pessoas", "pessoas"
  add_foreign_key "habilidades_pessoas", "habilidades"
  add_foreign_key "habilidades_pessoas", "pessoas"
  add_foreign_key "permissions_roles", "permissions"
  add_foreign_key "permissions_roles", "roles"
  add_foreign_key "pessoas", "circulos"
  add_foreign_key "pessoas", "encontros"
  add_foreign_key "pessoas", "tipos"
  add_foreign_key "servicos", "encontros"
  add_foreign_key "servicos", "equipe_funcoes"
  add_foreign_key "servicos", "pessoas"
  add_foreign_key "uos", "cidades"
  add_foreign_key "uos", "estados"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "uos"
end
