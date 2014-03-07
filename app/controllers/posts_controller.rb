require 'socket'

class PostsController < ActionController::Base

$message = ""

def new
	$str = "jajaja"
  	port = '2627'
    @descriptors = Array::new
    @serverSocket = TCPServer.new("127.0.0.1", port)
    @serverSocket.setsockopt(:SOCKET, Socket::SO_REUSEADDR, 1)
    $message = ("Chatserver startet on port %d\n " + port)
    @descriptors.push(@serverSocket)
  end

  def run
    while 1
    res = select(@descriptors, nil, nil, nil)
    if res != nil then
      for sock in res[0]
        if sock == @serverSocket then
          accept_new_connection
        else
          if sock.eof? then
            str = printf("Client left %s:%s\n", sock.peeraddr[2], sock.peeraddr[1])
            broadcast_string(str, sock)
            sock.close
            @descriptors.delete(sock)
          else
            str = printf("[%s|%s]:%s,", sock.peeraddr[2], sock.peeraddr[1], sock.gets())
            broadcast_string(str, sock)
          end
        end
      end
    end
  end
end

  private

  def broadcast_string(str, omit_sock)
    @descriptors.each do |clisock|
    if clisock != @serverSocket && clisock != omit_sock 
     $message1 = clisock.write(str)
      end
      end 
    end

  def accept_new_connection
    newsock = @serverSocket.accept
    @descriptors.push(newsock)
    newsock.write("You have been accept into the ruby chatserver, GRAATTuuuuuIS!!\n")
    str = printf("Client joined %s:%s\n", newsock.peeraddr[2], newsock.peeraddr[1])
    broadcast_string(str, newsock)
  end

  def add

  end

#	myPostsController = PostsController.new(2626)
#	myPostsController.run
end