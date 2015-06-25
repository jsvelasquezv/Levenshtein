require 'gtk3'
require_relative 'transformar'
include Transformar
#
#
#
class Interfaz < Gtk::Window
  def initialize
    super
    set_title 'Tranformación de cadena'
    signal_connect 'destroy' do
      Gtk.main_quit
    end
    init_ui
    set_default_size 500, 250
    set_window_position(:center)
    show_all
  end

  def init_ui
    set_border_width 15

    table = Gtk::Table.new 8, 5, false
    table.set_column_spacings 3

    titulo = Gtk::Label.new 'Tranformación'

    alinear = Gtk::Alignment.new 0, 0, 0, 0
    alinear.add titulo
    table.attach(alinear, 0, 3, 0, 1,
                 Gtk::AttachOptions::FILL,
                 Gtk::AttachOptions::SHRINK, 0, 0)

    @origen = Gtk::Entry.new
    table.attach(@origen, 0, 1, 2, 3,
                 Gtk::AttachOptions::FILL,
                 Gtk::AttachOptions::SHRINK, 1, 1)

    @origen.signal_connect 'key-release-event' do |w, e|
      on_key_release(w, e, @origen)
    end

    arrow = Gtk::Label.new 'U ==> V'
    table.attach(arrow, 1, 2, 2, 3,
                 Gtk::AttachOptions::FILL,
                 Gtk::AttachOptions::SHRINK, 1, 1)

    @destino = Gtk::Entry.new
    table.attach(@destino, 2, 3, 2, 3,
                 Gtk::AttachOptions::FILL,
                 Gtk::AttachOptions::SHRINK, 1, 1)

    @destino.signal_connect 'key-release-event' do |w, e|
      on_key_release_two(w, e, @destino)
    end

    @transformar = Gtk::Button.new(label:  'Transformar')
    @transformar.set_size_request 70, 25
    table.attach(@transformar, 4, 5, 2, 3,
                 Gtk::AttachOptions::FILL,
                 Gtk::AttachOptions::SHRINK, 1, 1)

    @transformar.signal_connect 'clicked' do
      on_clicked(@origen, @destino)
    end

    titulo_dos = Gtk::Label.new 'Resultado'
    table.attach(titulo_dos, 0, 3, 3, 4,
                 Gtk::AttachOptions::FILL | Gtk::AttachOptions::EXPAND,
                 Gtk::AttachOptions::SHRINK | Gtk::AttachOptions::EXPAND, 1, 1)

    frame = Gtk::Frame.new
    table.attach(frame, 0, 3, 4, 8,
                 Gtk::AttachOptions::FILL | Gtk::AttachOptions::EXPAND,
                 Gtk::AttachOptions::FILL | Gtk::AttachOptions::EXPAND, 1, 1)

    ayuda = Gtk::Button.new(label: 'Ayuda', mnemonic:  nil, stock_id:  nil)
    ayuda.set_size_request 70, 25
    table.attach(ayuda, 4, 5, 3, 4,
                 Gtk::AttachOptions::FILL | Gtk::AttachOptions::EXPAND,
                 Gtk::AttachOptions::SHRINK | Gtk::AttachOptions::EXPAND, 1, 1)

    salir = Gtk::Button.new(label: 'Salir', mnemonic: nil, stock_id: nil)
    salir.set_size_request 70, 25

    salir.signal_connect 'clicked' do
      Gtk.main_quit
    end

    table.attach(salir, 4, 5, 5, 6,
                 Gtk::AttachOptions::FILL | Gtk::AttachOptions::EXPAND,
                 Gtk::AttachOptions::SHRINK | Gtk::AttachOptions::EXPAND, 1, 1)

    @label = Gtk::Label.new 'Origen'
    label_tres = Gtk::Label.new '==>'
    @label_dos = Gtk::Label.new 'Destino'
    @label_cuatro = Gtk::Label.new 'Numero de operaciones: '
    @label_resultado = Gtk::Label.new ' '

    @table_dos = Gtk::Table.new 3, 5, false
    table.set_column_spacings 4

    @table_dos.attach(@label, 0, 1, 0, 1,
                     Gtk::AttachOptions::FILL | Gtk::AttachOptions::EXPAND,
                     Gtk::AttachOptions::SHRINK | Gtk::AttachOptions::EXPAND,
                     1, 1)
    @table_dos.attach(label_tres, 1, 2, 0, 1,
                     Gtk::AttachOptions::FILL | Gtk::AttachOptions::EXPAND,
                     Gtk::AttachOptions::SHRINK | Gtk::AttachOptions::EXPAND,
                     1, 1)
    @table_dos.attach(@label_dos, 2, 3, 0, 1,
                     Gtk::AttachOptions::FILL | Gtk::AttachOptions::EXPAND,
                     Gtk::AttachOptions::SHRINK | Gtk::AttachOptions::EXPAND,
                     1, 1)
    @table_dos.attach(@label_cuatro, 0, 1, 2, 3,
                     Gtk::AttachOptions::FILL | Gtk::AttachOptions::EXPAND,
                     Gtk::AttachOptions::SHRINK | Gtk::AttachOptions::EXPAND,
                     1, 1)
    @table_dos.attach(@label_resultado, 0, 3, 4, 5,
                      Gtk::AttachOptions::FILL | Gtk::AttachOptions::EXPAND,
                      Gtk::AttachOptions::SHRINK | Gtk::AttachOptions::EXPAND,
                      1, 1)
    frame.add(@table_dos)

    add table
  end

  def on_clicked(u, v)
    resultado = transformar(u.text, v.text)
    tamano_u = u.text.length
    tamano_v = v.text.length
    @label_cuatro.set_text 'Numero de operaciones: ' + resultado[tamano_u][tamano_v].to_s
    string_resultado = ' ' 
    (0..tamano_v).each do |j|
        (0..tamano_u).each do |i|
             string_resultado += '|' + resultado[i][j].to_s
        end
        string_resultado += '|
 '
    end
   
    @label_resultado.set_text string_resultado
  end

  def on_key_release(sender, _event, _label)
    @label.set_text sender.text
  end

  def on_key_release_two(sender, _event, _label)
    @label_dos.set_text sender.text
  end
end

Gtk.init
Interfaz.new
Gtk.main
